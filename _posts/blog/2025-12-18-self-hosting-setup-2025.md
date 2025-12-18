---
layout: post
title: "Self Hosting Setup - 2025"
date: 2025-12-18 22:54:12 +0530
category: blog
tags: self-hosting servers
description: "Software that I self host as of 2025."
---

It's been [two years]({% post_url 2023-02-19-self-hosting-setup-2023 %}) since the last self-hosting setup post. The setup largely remained pretty much the same with the following changes:

* [piHole](https://pi-hole.net/) and [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy) has been replaced with [Adguard Home](https://adguard.com/en/adguard-home/overview.html) since it does both.  
* [photoprism](https://www.photoprism.app/) \- self-hosted alternative to google photos and iCloud photos. I have bought a new iPhone with iCloud plans for my family, but I'm still backing up all the photos here just in case. I am planning to explore immich in the next year when I get some time.  
* loki, prometheus, grafana, blackbox-exporter and alertmanager \- for observability.  
* [jellyfin](https://jellyfin.org/) \- currently testing as an alternative to plex.  
* [uptime-kuma](https://uptime.kuma.pet/) \- for uptime monitoring.  
* [Actual Budget](https://actualbudget.org/) \- helps me to keep track of my finances. Earlier, I was using MyExpenses in android which is open-source with some paid features and since I'm not carrying my android phone daily, I moved to actual and it's been great so far.

I added two servers in late 2023 in addition to the raspberry pi and they’ve been running for 2 years without any problems:

1. `blr` \- server from DigitalOcean in Bangalore region. Takes care of latency sensitive and critical services.  
2. `hydra` \- server from Hetzner in Germany. The arm64 shared servers are good in terms of price-to-performance ratio. I use this server for all the resource heavy services.  
3. `pi` \- a raspberry pi 4B connected to my home network and runs a DNS server alone for now.

All the services are deployed as docker containers via ansible and terraform. I talk to all these servers via tailscale SSH.