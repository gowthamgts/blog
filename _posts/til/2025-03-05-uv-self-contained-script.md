---
layout: post
title: "Python self-contained script execution with uv"
date: 2025-02-06 22:44:49 +0530
category: til
tags: python uv
description: This entry is about running a self-contained Python script with uv.
---

I've been playing with `uv` a lot lately for some python automation projects. TIL, `uv` supports running a single python file that has inline dependency declarations and runtime.

Official documentation - [https://docs.astral.sh/uv/guides/scripts](https://docs.astral.sh/uv/guides/scripts).

```shell
# create a script
uv init --script example.py --python 3.13

# add depedencies
uv add --script example.py 'requests' 'pandas'

# run the script
uv run example.py
```
