---
layout: home
---

<picture>
  <source srcset="/static/img/dp.webp" type="image/webp">
  <img src="/static/img/dp.jpg" alt="Gowtham's Profile Picture" width="200" height="200">
</picture>

Hello 👋, I'm Gowtham Gopalakrishnan and I currently work as Staff Systems Engineer at [Freshworks](https://freshworks.com). I'm planning to write here regularly about the things I learn along the way. Check out the [TIL](/til/) or the [blog](/blog/) entries.

Apart from work, I wander around servers most of the time. I try to [self-host](/blog/self-hosting/) most of the software I use. I do occasionally [contribute](https://github.com/gowthamgts) to open-source projects.

I also love playing RTS and castle-simulation games ([Anno 1800](https://store.steampowered.com/app/916440/Anno_1800/), [Cities Skylines](https://www.paradoxinteractive.com/games/cities-skylines/about), [Stronghold Crusader 2](https://store.steampowered.com/app/232890/Stronghold_Crusader_2), [Factorio](https://www.factorio.com), etc). I also do lan party and play Call of Duty with an online friend, whom I met about 5 years ago.

<h2>Recent Blog Entries</h2>
<ul id="post-list">
  {% assign blog_entries = site.posts | where_exp: "post", "post.category != 'til'" %}
  {% for post in blog_entries limit: 5 %}
    <li>
      <small>{{ post.date | date_to_string }}</small> &nbsp;
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>

<i>You can contact me at blog(@)gowtham.dev. site built with [jekyll](https://jekyllrb.com/).</i>
