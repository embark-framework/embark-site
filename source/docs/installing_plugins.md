title: Installing Plugins
---

**To add a plugin to embark:**

1. Add the npm package to package.json
   e.g ``npm install embark-solium --save``
2. Then add the package to ``plugins:`` in embark.json
   e.g ``"plugins": { "embark-solium": {} }``


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

```Json
"plugins": { "embark-solium": {"context": ["build", "run"]} } 
```

This can be quite useful to limit plugins to run only in certain contextes.  (note: newer plugins can use an API to automatically detect the context)

