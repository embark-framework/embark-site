title: Configuring Embark
---

`embark.json`
<pre><code class="json">{
  "contracts": ["contracts/**"],
  "app": {
    "js/dapp.js": ["app/dapp.js"],
    "index.html": "app/index.html",
    "images/": ["app/images/**"]
  },
  "buildDir": "dist/",
  "config": "config/",
  "versions": {
    "web3": "1.0.0-beta.34",
    "solc": "0.4.17",
    "ipfs-api": "17.2.4"
  },
  "plugins": {
  }
}
</code></pre>

### contracts

List of directories in which embark should look for contracts. These typically are GLOB expressions (e.g `["contracts/**/*.sol"]` will match all sol files inside any folders inside contracts/)

### pipeline

The mapping between the output files and the source. e.g `"js/dapp.js": ["app/dapp.js"]` will run `app/dapp.js` though the embark pipeline, and output the result into `dist/js/dapp.js`

### build directory

The directory to which embark should output the dapp. (default is `dist/`)

### config

Location of config files, if this is a string (e.g `"config/"`) will it assumed to the directory in which the config are located. However, you can also specify an object with the
location of each config file, if set to `false` then that component will be disabled in embark. for e.g

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

Here you can optionaly specify the versions of the library to be used by Embark. Embark will automatically download the specific library version if necessary. It's possible to override this in other config files such as `contracts.json` on a per enviroment basis.

### plugins

List of plugins. (see [plugin section](installing_plugins.html))

