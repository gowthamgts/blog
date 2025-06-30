---
layout: post
title: "Self Hosting Setup - 2023"
date: 2023-02-19 23:54:12 +0530
category: blog
tags: self-hosting servers
description: "Software that I self host as of 2023."
---

You don't know when an algorithm from a big corporation will end up blacklisting you and removes access to your online accounts. I have read [a](https://news.ycombinator.com/item?id=13657282) [lot](https://news.ycombinator.com/item?id=24952202) [of](https://news.ycombinator.com/item?id=31815289) hacker news threads where big corporations end up disabling access to accounts without any way to contact support.

Though, I'm not currently self-hosting email (_and I strongly recommend you not to_) for [good reasons](https://cfenollosa.com/blog/after-self-hosting-my-email-for-twenty-three-years-i-have-thrown-in-the-towel-the-oligopoly-has-won.html), it's a good start to consider hosting the easy things. I own a [raspberry pi model](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/) 4B which I thankfully got before the pandemic.

**Here's the list of items I self-host:**

- [piHole](https://pi-hole.net) - a rock solid DNS server. It blocks trackers across the network for all of our devices. [Adguard Home](https://adguard.com/en/adguard-home/overview.html) is also a good alternative.
- [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy) - An upstream for piHole since it doesn't support DNS-over-HTTPS. I'm currenty using [cloudflare's DoH](https://developers.cloudflare.com/1.1.1.1/encryption/dns-over-https/) as upstream.
- [miniflux](https://miniflux.app) - simple, clean and minimalistic RSS reader. I follow and read about other bloggers and news publications via miniflux.
- [syncthing](https://syncthing.net) - synchronises and backs up my data across all devices and servers. Mobile clients are also available.
- [plex](https://www.plex.tv) - local media server. I mostly consume new content from online streaming platforms but there are some older movies I have in mp4/mkv format.
- [tranmission-daemon](https://transmissionbt.com) - a lightweight torrent client with a web UI. Since I have a higher FUP plan from ACT (_~4TB per month_), I seed linux distros and [scientific papers](https://academictorrents.com).

**Things I wish to self-host in future:**

- [headscale](https://github.com/juanfont/headscale) - open-source co-ordination server for [tailscale](https://tailscale.com) network. I use tailscale for all peer-to-peer communications between my devices and I want to move away to headscale in future.
- [maddy](https://maddy.email) - all in one email server. I currently use [Fastmail](https://fastmail.com), but I want to go with a self-hosting solution.

If you've found any interesting software that I'm missing out on, please let me know.
