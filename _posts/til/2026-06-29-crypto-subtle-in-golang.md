---
layout: post
title: "crypto/subtle in golang"
date: 2026-06-29 13:51:06 +0530
category: til
tags: golang
description: this entry discusses about `crypto/subtle` package in golang and when you should use them.
---

During a routine PR review, coderabbit flagged a auth check that goes something like this:

```golang
if r.Header.Get('Authorization') == MASTER_TOKEN {
    // allow
}
```

It proposed a change to use `crypto/subtle` instead of a direct comparison to avoid [timing attacks](https://en.wikipedia.org/wiki/Timing_attack). This is one of the techniques which an attacker can use to guess the length of the string and then do a targetted brute-force attack. that based on the length of the secret, the attacker can guess the 