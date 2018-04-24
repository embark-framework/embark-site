<style>

.startbuttons {
  padding-bottom: 80px;
}

.startbutton {
  font-size: 20px;
  padding-top: 15px;
  padding-bottom: 15px;
  background-color: #61dafb;
  color: #000000;
  padding: 10px 25px;
  text-decoration: none;
  font-family: Roboto, "Helvetica Neue", Helvetica, Arial, sans-serif;
}

.startlink {
  color: white;
  font-family: Roboto, "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 20px;
  text-decoration: none;
  padding-left: 15px;
}

.description {
  padding-top: 20px;
  font-size: 30px;
  font-weight: 200;
}

#banner-title {
  padding-top: 100px;
  font-size: 60px;
  font-weight: 700;
}

</style>

<header id="banner" class="wrapper">
  <div class="inner">
    <h2 id="banner-title">Embark</h2>
    <p class="description">A Powerful framework to develop Decentralized Applications</p>
    <div id="banner-start">
      <span id="banner-start-command">npm install embark -g</span><a id="banner-start-link" href="docs/"><i class="fa fa-arrow-right"></i></a>
    </div>
    <div class="startbuttons">
      <a class="startbutton" href="docs/">Get Started</a>
      <a class="startlink" href="docs/quick_start.html">Take the Tutorial ></a>
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
