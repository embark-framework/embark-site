title: Configuring Embark
---

Embark offers a lot of fine control when it comes to configuring the different parts of our decentralized application. In this guide we'll take a closer look at the basic configuration options provided by our application's `embark.json` file, which are mainly relevant for, but not restricted to, our application structure.

**For configuration options related to connecting to a blockchain client, [deploying your Smart Contracts](contracts_configuration.html), [decentralized storage](storage_configuration.html), [Whisper](messages_configuration) or [ENS](naming_configuration.html), please head over to the dedicated configuration guides respectively.**

## Overview

Every application [created with Embark](create_project.html) comes with an `embark.json` file. This file configures where Embark has to look for Smart Contract files and assets, as well as plugins options. Here's what a freshly scaffolded `embark.json` file could look like:

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
    "web3": "1.0.0-beta",
    "solc": "0.4.25",
    "ipfs-api": "17.2.4"
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

Let's look at the different options and learn what they do and mean.

### contracts

This is a list of directories in which Embark should look for Smart Contract files. These typically are globbing patterns (e.g `["contracts/**/*.sol"]` will match all sol files inside any folders inside `contracts/`).

### app

Everything inside `app` configures the assets of our application, which could be anything from HTML, JavaScript to CSS and other assets. JavaScript source files are compiled using webpack to create a bundle, all other file types are simply copied to the specified destination.

In the key/value pairs of `app`, every key describes the destination, while the value describes a list of glob patterns for files to be transformed and copied.

  - **js/dapp.js** - This is the JavaScript bundle that contains our application. Specifically, all files that are defined in this option (`app/dapp.js`).
  - **index.html** - The entry point of our application (`app/index.html`)
  - **images** - All image assets of our application that we can find in `app/images/`.

Change these configurations as you need.

### buildDir

The directory to which the build artifacts are being moved to. Everything inside this configured folder can be considered a production ready build (default is `dist/`).

### config

This is the location of the configuration files. There are different options to configure those:

* **A string** (e.g `"config/"`) - Will assume the directory in which the configuration files are located (`blockchain.js`, `contracts.js`, etc).
* **An object**:
  * Each property would configure the path of each configuration file
  * Configuration properties can be set to false to disable the component/service in question

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

### versions (3rd-party libraries)

Here you can optionally specify the versions of the library to be used by Embark. Embark will automatically download the specific library version if necessary. It's possible to override this in other configuration files such as `contracts.json` on a per environment basis.

### plugins

This is a list of installed plugins. For more information on Plugins, head over to our [Plugins guide](installing_plugins.html).

### options

The `options` property enable us to configure options for specific components and services of Embark and our application. Currently supported are options for the `solc` compiler. 
<pre><code class="json">...
  "options": {
    "solc": {
      "optimize": true,
      "optimize-runs": 200
    }
  }
...
</code></pre>

