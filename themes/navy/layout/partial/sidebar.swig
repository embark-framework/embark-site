<aside id="sidebar" role="navigation">
  <div class="inner">
    <label id="version-select-container"><b>Version:</b> <select id="version-select">
        <option value="3.2">3.2.x</option>
        <option value="4.alpha">4.alpha.x</option>
      </select></label>
    <script>
      const versionSelector = document.getElementById('version-select');
      // TODO change these URLS to the right ones once Iuri or someone else has create the Netlify project
      // These still work right now however
      // TODO use a config file?
      const VERSIONS = {'3.2': 'https://embark.status.im/docs', '4.beta.x': 'https://embark-site-develop.netlify.com/docs/'};
      const currentVersion = Object.keys(VERSIONS).find(v => {
        return window.location.href.indexOf(VERSIONS[v]) > -1;
      });

      if (currentVersion && versionSelector) {
        versionSelector.value   = currentVersion;
      }
      versionSelector.onchange = function(e) {
        if (!VERSIONS[e.target.value]) {
          console.error('Unknown version:', e.target.value);
          return;
        }
        window.location.href = VERSIONS[e.target.value];
      };
    </script>

    {{ doc_sidebar('sidebar') }}
  </div>
</aside>
