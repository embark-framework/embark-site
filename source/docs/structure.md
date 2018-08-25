title: Structure
---

Once initialised, here's what your project folder will look like:

``` plain
.
├── app/
├── contracts/
├── config
|   ├── blockchain.js
|   └── contracts.js
|   └── storage.js
|   └── communication.js
|   └── webserver.js
└── test/
└── dist/
└── chains.json
└── embark.json
```

### app/

DApp Web code goes here. See embark.json on how you customize the pipeline.

### contracts/

Smart Contracts go here. When active, Embark will automatically compile, deploy & track contracts in this directory. Embark will detect changes made to a contract and re-deploy it and its dependencies if necessary.

### config/

The configuration files for the different components of the stack can be found here.

**blockchain.js**
Contains the configuration used for embark to run a node with go-ethereum or a simulator.

**contracts.js**
Configuration for contracts, including their arguments, relationship between them. It's also possible to specify where to deploy the contracts and how the dapp should attempt to connect to a node.
Please see [Configuring Contracts](contracts.html) for more details.

**storage.js**

You can configure what storage component to use (e.g IPFS) and its config details including what node to connect to, get & uplaod files from, etc..

**communication.js**

You can configure what communication component to use (e.g Whisper) and its config details including what node to connect to.

**webserver.js**

Dev web server config, specifically the host and port to listen to.

### test/

Tests Folder. This where you typically put the code to test smart contracts. Embark includes a [testing framework](contracts_testing.html)

### dist/

The build output of your dapp will be put here. You can then distribute your app with this folder

### chains.json

This file is used to keep track of the deployed contracts in each chain. See chains file documentation for more information

### embark.json

Embark is quite flexible and you can configure your own directory structure using ``embark.json``. This file is also used to specify embark plugins and other configurations. More information can be found in [configuring embark.json](configuration.html)

<br>
## Simple template structure

If you create the project with the `--simple` option, then the template will be simpler.

``` plain
.
├── contracts/
└── test/
└── dist/
├── contracts.js
└── chains.json
└── embark.json
```

Most components will be disabled except the contracts but you can still re-enable in `embark.json` if you so need. The `contracts.js` config file is in the top directory since that's what is defined in the config.

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

