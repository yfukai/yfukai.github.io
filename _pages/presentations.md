---
layout: page
permalink: /presentations/
title: presentations
nav: true
nav_order: 3

pagination:
  enabled: true
  collection: presentations
  per_page: 5

---
Total items: {{ paginator.items | size }}
<!-- _pages/presentations.md -->
<div class="publications">
Total items: {{ paginator.items | size }}

<ul>
{% for item in paginator.presentations %}
  <li>
    <h2>{{ item.name }}</h2>
    <p>{{ item.description }}</p>
  </li>
{% endfor %}
</ul>

<div class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path }}" class="previous">Previous</a>
  {% endif %}
  {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path }}" class="next">Next</a>
  {% endif %}
</div>

</div>
