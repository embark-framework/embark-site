<header id="banner" class="wrapper">
  <div class="inner">
    <h2 id="banner-title">{{ page.subtitle }}</h2>
    <div id="banner-start">
      <span id="banner-start-command">npm install embark -g</span><a id="banner-start-link" href="docs/"><i class="fa fa-arrow-right"></i></a>
    </div>
    <div>
      <a href="docs/">Get Started</a>
      <a href="tutorials/">Take the Tutorial</a>
    </div>
  </div>
</header>
<div id="content-wrap">
  <div class="wrapper">
    <div class="inner">
      {{ page.content }}

      <ul id="intro-cmd-wrap">
        <li class="intro-cmd-item">npm install embark -g</li>
        <li class="intro-cmd-item">embark demo</li>
        <li class="intro-cmd-item">cd embark_demo</li>
        <li class="intro-cmd-item">embark run</li>
      </ul>
      <div id="intro-get-started-wrap">
        <a href="docs/" id="intro-get-started-link">{{ __('index.get_started') }}</a>
      </div>
    </div>
  </div>
</div>
