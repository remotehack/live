--- 
title: 🤓 Stats for Nerds
permalink: /stats/ 
layout: layout
---
<style>
    details { background: rgba(0,0,0,.2); text-align: left; width: 100%; max-width: 100%; padding: 1rem; box-sizing: border-box;}
    summary { cursor: pointer;}
</style>

{% assign all_eps = site.episodes %}
## Number of episodes: {{ all_eps | size | plus:1 }}

{% assign shortest = all_eps | sort:"duration" | first %} 
## Shortest episode: 
{% include episodelink.html episode=shortest %} ({{ shortest.duration }})

{% assign longest = all_eps | sort:"duration" | last %} 
## Longest episode: 
{% include episodelink.html episode=longest %} ({{ longest.duration }})

{% assign episodes_by_day = all_eps | group_by_exp:"episode","episode.pubDate | date: '%Y-%m-%d'" %}
{% assign episodes_by_day_count = episodes_by_day | group_by_exp:"group","group.items | size" %}


## Number of episodes per day

{% assign counts_sorted = episodes_by_day_count | sort:"name" | reverse %}
{% for obj in counts_sorted %}
<details>
<summary>{{ obj.name }} episodes ({% for day in obj.items %}{{ day.name | date_to_long_string }}{% unless forloop.last %}, {% endunless %}{% endfor %})</summary>
{% for day in obj.items %}
<details>
<summary>{{ day.name | date_to_long_string }}</summary>
<ul>
{% for ep in day.items %}
<li>{% include episodelink.html episode=ep %} </li>
{% endfor %}
</ul>
</details>
{% endfor %}
</details>
{% endfor %}