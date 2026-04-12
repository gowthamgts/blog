---
layout: post
title: "Why didn't IPv6 work in my home network?"
date: 2026-04-12 19:34:12 +0530
category: blog
tags: servers self-hosting home-network debugging
description: "Debugging why IPv6 was not working on my home network even though my ISP supports it."
---
<details>
  <summary>TLDR (click to expand)</summary>
  It was a setting on my Adguard Home DNS which disables IPv6 by default.
</details>

I've been using ACT broadband for my home network for quite a while and they did not support IPv6 for quite some time. A few years back I contacted their support, they confirmed they are slowly rolling it out for users in Chennai. I was one of those users and I enabled IPv6 in my router and it worked without any issues. I just did a quick test and just forgot about it.

> There are lot of benefits in enabling IPv6 in your network like reduced latencies, better P2P connections due to the lack of NAT traversals, SLAAC, etc.
{: .info }

I recently got an IKEA desk and I had to shift everything around since it's a big desk. As part of it, I was testing my network connectivity and noticed that `ping google.com` succeeded, but `ping6 google.com` failed. Weird, I thought my ISP might have disabled IPv6 again. I confirmed ISP connectivity via IPv6 into my router's admin portal. Then I shouldn't have a problem connecting to IPv6???

Maybe an issue with the device? I checked my macOS network settings and I have IPv6 allowed there as well.

![macos settings](/static/img/ipv6/macos-settings.png)

I logged into the raspberry pi connected over LAN to my router and noticed the same issue there. Since I'm running my own DNS server, I checked my router's DNS settings for IPv6 DNS server address and cross-verified the ip address with my pi's ethernet interface.

![router IPv6 DNS settings](/static/img/ipv6/router-dns.png)

Maybe a DHCP issue with IPV6 DNS? To rule it out, I wanted to try pinging an IPv6 address directly - maybe google - and when I tried running `dig AAAA google.com`, no results from the DNS. Obviously, google will support IPv6 so I knew something was wrong with my DNS server. I then realized [moving to Adguard Home]({% post_url blog/2025-12-18-self-hosting-setup-2025 %}) DNS last year. When I checked Adguard Home's DNS server settings, I found this small toggle that I overlooked.

![Adguard DNS settings](/static/img/ipv6/adguard-dns-settings.png)

I unchecked that setting, saved and now I'm rocking IPv6 again.

```shell
$ ping -4 google.com -c 5
PING google.com (172.217.24.110) 56(84) bytes of data.
64 bytes from lcmaaa-ap-in-f14.1e100.net (172.217.24.110): icmp_seq=1 ttl=118 time=1.58 ms
64 bytes from lcmaaa-ap-in-f14.1e100.net (172.217.24.110): icmp_seq=2 ttl=118 time=1.53 ms
64 bytes from lcmaaa-ap-in-f14.1e100.net (172.217.24.110): icmp_seq=3 ttl=118 time=1.52 ms
64 bytes from lcmaaa-ap-in-f14.1e100.net (172.217.24.110): icmp_seq=4 ttl=118 time=1.64 ms
64 bytes from lcmaaa-ap-in-f14.1e100.net (172.217.24.110): icmp_seq=5 ttl=118 time=1.56 ms

--- google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 10ms
rtt min/avg/max/mdev = 1.519/1.565/1.637/0.065 ms

$ ping -6 google.com -c 5
PING google.com(maa05s16-in-x0e.1e100.net (2404:6800:4007:817::200e)) 56 data bytes
64 bytes from maa05s16-in-x0e.1e100.net (2404:6800:4007:817::200e): icmp_seq=1 ttl=118 time=1.61 ms
64 bytes from maa05s16-in-x0e.1e100.net (2404:6800:4007:817::200e): icmp_seq=2 ttl=118 time=1.56 ms
64 bytes from maa05s16-in-x0e.1e100.net (2404:6800:4007:817::200e): icmp_seq=3 ttl=118 time=1.56 ms
64 bytes from maa05s16-in-x0e.1e100.net (2404:6800:4007:817::200e): icmp_seq=4 ttl=118 time=1.66 ms
64 bytes from maa05s16-in-x0e.1e100.net (2404:6800:4007:817::200e): icmp_seq=5 ttl=118 time=1.60 ms

--- google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 12ms
rtt min/avg/max/mdev = 1.557/1.597/1.661/0.063 ms
```
---------