title: Configuring Embark
---

`embark.json`
<pre><code class="json">{
  "contracts": ["contracts/**"],
  "app": {},
  "buildDir": "build/",
  "config": {
    "contracts": "contracts.js",
    "blockchain": false,
    "storage": false,
    "communication": false,
    "webserver": false
  },
  "versions": {
    "solc": "0.4.25"
  },
  "plugins": {

  },
  "options": {
    "solc": {
      "optimize": true,
      "optimize-runs": 200
    }
  }
}
</code></pre>

### contracts

List of directories in which embark should look for contracts. These typically are GLOB expressions (e.g `["contracts/**/*.sol"]` will match all sol files inside any folders inside `contracts/`)

### pipeline

The mapping between the output files and the source. e.g `"js/dapp.js": ["app/dapp.js"]` will run `app/dapp.js` though the embark pipeline, and output the result into `dist/js/dapp.js`
In a contracts-only project, this is typically empty.

### build directory

The directory to which embark should output the dapp. (default is `dist/`)

### config

This is the location of the config files, if it is:

* A string (e.g `"config/"`) will assume the directory in which the config files are located.
* An object:
  * Can be the location of each config file
  * Can be set to false to disable a component in embark. e.g

<pre><code class="json">...
  "config": {
    "contracts": "contracts.js",
    "blockchain": false,
    "storage": false,
    "communication": false,
    "webserver": false
  },
...
</code></pre>

### library versions

Here you can optionally specify the versions of the library to be used by Embark. Embark will automatically download the specific library version if necessary. It's possible to override this in other config files such as `contracts.json` on a per enviroment basis.

### plugins

List of plugins. (see [plugin section](installing_plugins.html))

### options

You can specify some options for specific components here.

For example to specify options for the solc compiler:
<pre><code class="json">...
  "options": {
    "solc": {
      "optimize": true,
      "optimize-runs": 200
    }
  }
...
</code></pre>

