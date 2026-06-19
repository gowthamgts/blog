---
layout: post
title: "Knowledge Graph"
date: 2026-06-19 20:44:49 +0530
category: til
tags: database system-design
description: Entry around knowledge graph - what it is and how it can be used for AI systems.
---
_This is more of a TID (Today I Discovered) rather than a TIL (Today I Learned) entry._

I have come across graph databases earlier, but was never able to wrap my head on why and where you needed it (until today). Apparently, graph databases are the perfect fit for [Knowledge Graph](https://en.wikipedia.org/wiki/Knowledge_graph) solutions where you have multiple entities that will be linked together by a relationship. ex: a user owning a laptop, a service depending on another service, etc.

This can be an efficient way to let your agents sift through a ton of data that your organisation currently has or will have. I’m currently bootstrapping my own personal agent (mostly by writing `SOUL.md`, `IDENTITY.md`, `FINANCIALS.md`, etc), but now I have a new toy to play and experiment with. I’ll try to write in detail about it when that happens.
