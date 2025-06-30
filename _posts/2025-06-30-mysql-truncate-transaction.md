---
layout: post
title: "MySQL truncate in transaction"
date: 2025-06-30 21:56:00 +0530
category: til
tags: database mysql
description: Figured out we should not use truncate in MySQL transactions.
---

MySQL truncate does an implicit commit. So, if you are using a transaction, it will commit the transaction and for any reason if you want to rollback, you will not be able to do it. Use `DELETE FROM table_name` instead.