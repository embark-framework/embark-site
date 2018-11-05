title: Installing Plugins
---

**To add a plugin to embark:**

1. Add the npm package to `package.json`
for e.g:
<pre><code class="shell">npm install embark-solium --save
</code></pre>
2. Then add the package to `plugins:` in `embark.json`
for e.g:
<pre><code class="json">"plugins": { "embark-solium": {} }
</code></pre>

**context**

Additionally, you can also specify the context a plugin should run in the plugin config options:
* context: {Array} Specifies the context(s) in which the plugin can run
  * any (default)
  * run
  * upload
  * build
  * simulator
  * blockchain
  * graph
  * test
  * templateGeneration
  * reset

e.g

<pre><code class="json">"plugins": { "embark-solium": {"context": ["build", "run"]} }
</code></pre>

This can be quite useful to limit plugins to run only in certain contexts (note: newer plugins can use an API to automatically detect the context.)

