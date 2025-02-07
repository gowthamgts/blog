---
title: TIL
layout: page
description: "Today I Learned entries that I learn every day, documented mostly for self."
---

<ul id="tags">
  {% assign blog_entries = site.posts | where: "category", "til" %}
    {% assign all_tags = blog_entries | map: "tags" | flatten | uniq | sort %}
    {% for tag in all_tags %}
      {% assign tag_posts = blog_entries | where_exp: "post", "post.tags contains tag" %}
      <li>
        <a href="/tag/{{ tag | slugify }}.html">
          #{{ tag }} ({{ tag_posts.size }})
        </a>
      </li>
    {% endfor %}
</ul>

<ul id="post-list">
  {% for post in blog_entries %}
    <li>
      <small>{{ post.date | date_to_string }}</small> &nbsp;
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
