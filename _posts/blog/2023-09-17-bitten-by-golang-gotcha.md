---
layout: post
title: "Bitten by Golang Gotcha"
date: 2023-09-17 00:11:18 +0530
category: blog
tags: golang
description: "This entry discusses how I debugged duplicate message deliveries from SQS and why having dead letter queues are important."
---

> Update 19, Sep 2023: Go team [confirmed](https://go.dev/blog/loopvar-preview) the default behaviour will be changed from version 1.22.

![AI generated image of a gopher biting a man](/static/img/gopher.jpg "AI generated image of a gopher biting a man")

At work, both my previous project and the current project I'm working on relies on SQS for failure retries with exponential backoff. The current project is a _webhook service_ that delivers webhooks to our customers from our products and also among internal services. We use SQS for failure retries and the current queue setup looks like this:

| queue-name | delay | offset-delay (hh:mm:ss) | visibility-timeout | max-receive-count |
| ---------- | ----- | ----------------------- | ------------------ | ----------------- |
| failed-0   | 30s   | 00:00:30                | 10m                | 10                |
| failed-1   | 1m    | 00:01:30                | 10m                | 10                |
| failed-2   | 2m    | 00:03:30                | 10m                | 10                |
| failed-4   | 4m    | 00:07:30                | 10m                | 10                |
| failed-8   | 8m    | 00:15:30                | 10m                | 10                |
| failed-15  | 15m   | 00:30:30                | 10m                | 10                |

"_visibility timeout_" above refers to the maximum time SQS will wait before sending the same message to another consumer API call **if the message is not deleted** by your consumer. This will be helpful in cases where your consumer pod/instance crashed and the messages should be re-delivered to other consumers. "_maximum receive count_" refers to the maximum number of consumer deliveries SQS will do for a same request before moving it to the [dead-letter](https://en.wikipedia.org/wiki/Dead_letter_queue) queue.

When a request fails on the first try due to various reasons (connection timeout, non-2xx response, etc), the service will push the request to the first failed queue (failed-0) and mark it as failed. The failed consumers should delete the message from the current failed queue (failed-0) irrespective of the result of the operation, else they'll become visible to subsequent `ReceiveMessage` API calls.

We were in the middle of migrating internal test endpoints and found that one endpoint was failing a lot because of connection timeouts and our golang consumers were unable to keep up with the traffic (~20k rps). All these requests were pushed to the failed queue (failed-0) and our consumers were accepting the messages, but only a very few of these failed messages were deleted and pushed to the second failed queue (failed-1). Also, I can see our consumer processing the **same message 10 times** (what?).

Meanwhile the `NumberOfMessagesNotVisible` metric (the number of messages that are currently processed by the consumers) for the first queue spiked to the maximum limit of 120K allowed by SQS. Post this limit SQS won't return any messages in `ReceiveMessage` api calls causing a delayed delivery for all the failed messages.

So, there are two issues at hand - the consumer is processing duplicate messages and the `NumberOfMessagesVisible` reached the 120k limit. Just to be sure that the producer is not pushing any duplicate messages to the SQS queue, I checked the logs (we're using ELK stack internally) and can see we're producing the message only once. I also polled for messages multiple times in the AWS SQS console and there I don't see any duplicates (though it's very random and we can't be sure). So, the bug might be in the consumer code?!

I was also able to reproduce this in my local setup and started a debugging session to check whether SQS `ReceiveMessage` API call returned any duplicate messages. As per design, after receiving the messages via `ReceiveMessage`, each message will be pushed to a buffered channel which is consumed by a goroutine worker pool. The code looked like this:

```go
for {
	resp, err := SqsClient.ReceiveMessage(ctx, &sqs.ReceiveMessageInput{
		QueueUrl:              &queueUrl,
		MessageAttributeNames: []string{"ApproximateReceiveCount"},
		MaxNumberOfMessages:   10,
		WaitTimeSeconds:       20,
	})
	if err != nil {
		if ctx.Err() != nil {
			log.Ctx(ctx).Debug().Msg("context cancelled. stopping sqs reader")
			break
		}
		log.Ctx(ctx).Error().Err(err).Msg("error while calling ReceiveMessage")
		continue
	}

	// if resp is nil, log and continue
	if resp == nil {
		log.Ctx(ctx).Info().Msg("sqs receiveMessage response is nil")
		continue
	}

	// iterate and push each message to the buffered worker channel
	for _, msg := range resp.Messages {
		workerChan <- &msg
	}
}
```

Do you find anything weird in the snippet above? Look carefully again inside the `for` loop. Still nothing? I also didn't notice anything and started the debugger. Turns out, I'm bitten by the golang's [loop variable](https://github.com/golang/go/issues/20733) gotcha. Go by design handles `for` loop variables differently than other languages. If you pass the loop variables by reference in golang, it will always point to the last element. So when `&msg` was passed to the `workerChan` we sent the last element of `resp.Messages` 10 times and ignored the first 9 elements.

This explains why the 120k limit was also hit. When the worker goroutine consumes a message, it'll process it and delete it from the queue as required by SQS. Since we're deleting 1 in 10 messages and ignoring the other 9, after the configured visibility-timeout interval these messages will be returned again in `ReceiveMessage` API call. The below code fixes this issue:

```go
for _, msg := range resp.Messages {
	m := msg // assign it to a temp variable
	workerChan <- &m
}
```

This fix won't be needed in newer versions of go as per the [latest discussions](https://github.com/golang/go/issues/60078), but you never know when you need a rock solid observability for your entire infrastructure. In my case, having dead letter queues and alerts for `NumberOfMessagesNotVisible` helped narrowing down this issue faster. Always have dead-letter queues configured kids!
