---
layout: home
---

<picture>
  <source srcset="/static/img/dp.webp" type="image/webp">
  <img src="/static/img/dp.jpg" alt="Gowtham's Profile Picture" width="200" height="200">
</picture>

Hello 👋, I'm Gowtham Gopalakrishnan and I currently work as a Systems Engineer at [Freshworks](https://freshworks.com). I'm planning to write here regularly about the things I learn along the way. Check out the [TIL](/til.html) or the [blog](/blog.html) entries.

Apart from work, I wander around servers most of the time. I try to [self-host](/tag/self-hosting.html) most of the software I use. I do occasionally [contribute](https://github.com/gowthamgts) to open-source projects. I also love playing RTS and castle-simulation games ([Anno 1800](https://store.steampowered.com/app/916440/Anno_1800/), [Cities Skylines](https://www.paradoxinteractive.com/games/cities-skylines/about), [Stronghold Crusader 2](https://store.steampowered.com/app/232890/Stronghold_Crusader_2), [Factorio](https://www.factorio.com), etc), do Call of Duty lan parties to relax.

<div class="home-sections">
  <div class="home-section">
    <h2>Recent Entries</h2>
    <ul id="post-list">
      {% for post in site.posts limit: 15 %}
        <li>
          <small>{{ post.date | date_to_string }}</small> &nbsp;
          <a href="{{ post.url }}">{{ post.title }}</a>{% if post.category == 'til' %}<sup class="til-tag">TIL</sup>{% endif %}
        </li>
      {% endfor %}
    </ul>
  </div>
</div>

<i>You can contact me at blog(@)gowtham.dev. site built with [jekyll](https://jekyllrb.com/).</i>
