---
layout: post
title: "Python Type Ordering"
date: 2025-02-06 22:44:49 +0530
category: til
tags: python
description: This entry is about the ordering of types in Python.
---

Found out order of the types are important in the same python file for type hints. This will throw `Undefined name: B` error if the class is used before it's defined. For example, consider the following code:

```python
from typing import List

class A:
    items: List[B]

class B:
    name: str
```

To fix, we should reorder the classes:

```python
from typing import List

class B:
    name: str

class A:
    items: List[B]
```
