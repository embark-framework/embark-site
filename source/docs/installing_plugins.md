title: Installing Plugins
---

**To add a plugin to embark:**

1. Add the npm package to package.json
   e.g ``npm install embark-babel --save``
2. Then add the package to ``plugins:`` in embark.json
   e.g ``"plugins": { "embark-babel": {} }``
   * You can add plugin configurations inside the brackets
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

