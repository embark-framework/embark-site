<aside id="sidebar" role="navigation">
  <div class="inner">
    <label id="version-select-container"><b>Version:</b> <select id="version-select">
        <option value="docs">4.alpha.x</option>
        <option value="maintenanceDocs">3.2.x</option>
      </select></label>
    <script>
      const versionSelector = document.getElementById('version-select');
      const VERSIONS = ['docs', 'maintenanceDocs'];
      const currentVersion = VERSIONS.find(v => {
        return window.location.pathname.indexOf(v) > -1;
      });

      if (currentVersion && versionSelector) {
        versionSelector.value   = currentVersion;
      }
      versionSelector.onchange = function(e) {
        window.location.href = '/' + e.target.value;
      };
    </script>

    {{ doc_sidebar('sidebar') }}
  </div>
</aside>
