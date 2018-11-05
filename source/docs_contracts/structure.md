title: Structure
---

## Simple template structure

If you create the project with the `--simple` option, then the template will be simpler and made for contracts-only projects.
Once initialised, here's what your project folder will look like:

``` plain
.
├── contracts/
└── test/
└── dist/
├── contracts.js
└── chains.json
└── embark.json
```

### contracts/

Smart Contracts go here. When active, Embark will automatically compile, deploy & track contracts in this directory. Embark will detect changes made to a contract and re-deploy it and its dependencies if necessary.

### test/

Tests Folder. This where you typically put the code to test smart contracts. Embark includes a [testing framework](contracts_testing.html)

### dist/

The build output of your contracts will be put here. You can find the JSON files for each contract in the `dist/contracts/` folder

### contracts.js

**contracts.js**
Configuration for contracts, including their arguments, relationship between them. It's also possible to specify where to deploy the contracts and how the dapp should attempt to connect to a node.
Please see [Configuring Contracts](contracts.html) for more details.

### chains.json

This file is used to keep track of the deployed contracts in each chain. See chains file documentation for more information

### embark.json

Embark is quite flexible and you can configure your own directory structure using ``embark.json``. This file is also used to specify embark plugins and other configurations. More information can be found in [configuring embark.json](configuration.html)

## Re-enabling other components of the stack

When using the simple structure most components will be disabled except the contracts, but you can still re-enabled them in `embark.json` if you so need. The `contracts.js` config file is in the top directory since that's what is defined in the config.

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

