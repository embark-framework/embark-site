<aside id="sidebar" role="navigation">
  <div class="inner">
    <label id="version-select-container"><b>Version:</b> <select id="version-select">
        <option value="3.2">3.2.x</option>
        <option value="4.beta">4.beta.x</option>
      </select></label>
    <script>
      const versionSelector = document.getElementById('version-select');
      const VERSIONS = {'3.2': 'https://5ca245637a5327d3a6eb0e3e--embark-site-versions.netlify.com/', '4.beta': 'https://embark.status.im/docs'};
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
