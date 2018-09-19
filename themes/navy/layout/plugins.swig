<div id="content-wrap">
  <div class="wrapper">
    <div class="inner">
      <header id="plugin-list-header">
        <h1 id="plugin-list-title">{{ page.title }}</h1>
      </header>
      <p>Embark supports plugins to extend or enhance its own functionality or even to support other technologies in its stack.<br>
      Please refer to the documentation on <a href="docs/installing_plugins.html">how to install a plugin</a> or how to easily <a href="docs/creating_plugins.html">create one</a>!</p>
      <ul id="plugin-list">
        {% for plugin in site.data[page.data] %}
          {% if (!plugin.legacy) %}
            {{ partial('partial/' + page.partial, {plugin: plugin}) }}
          {% endif %}
        {% endfor %}
      </ul>

      <header id="plugin-list-header">
        <h1 id="plugin-list-title">Legacy</h1>
      </header>
      <p>This plugins are meant for Embark 3.1 and no longer necessary due to the new pipeline functionality in Embark 3.2.<br>
      Please see the new pipeline documentation <a href="docs/pipeline_and_webpack.html">here</a> for more information</p>
      <ul id="plugin-list">
        {% for plugin in site.data[page.data] %}
          {% if (plugin.legacy) %}
            {{ partial('partial/' + page.partial, {plugin: plugin}) }}
          {% endif %}
        {% endfor %}
      </ul>

    </div>
  </div>
</div>
