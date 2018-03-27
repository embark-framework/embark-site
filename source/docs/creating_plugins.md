title: Creating Plugins
---

**Creating a plugin:**

1. ``mkdir yourpluginname``
2. ``cd yourpluginname``
3. ``npm init``
4. create and edit ``index.js``
5. add the following code:

```Javascript
    module.exports = function(embark) {
    }
```

The ``embark`` object then provides an api to extend different functionality of embark.

**Usecases examples**

* plugin to add support for es6, jsx, coffescript, etc (``embark.registerPipeline``)
* plugin to add standard contracts or a contract framework (``embark.registerContractConfiguration`` and ``embark.addContractFile``)
* plugin to make some contracts available in all environments for use by other contracts or the dapp itself e.g a Token, a DAO, ENS, etc.. (``embark.registerContractConfiguration`` and ``embark.addContractFile``)
* plugin to add a libraries such as react or boostrap (``embark.addFileToPipeline``, ``embark.registerImportFile``)
* plugin to process contract's binary code before deployment (``embark.beforeDeploy``)
* plugin to specify a particular web3 initialization for special provider uses (``embark.registerClientWeb3Provider``)
* plugin to create a different contract wrapper (``embark.registerContractsGeneration``)
* plugin to add new console commands (``embark.registerConsoleCommand``)
* plugin to add support for another contract language such as viper, LLL, etc (``embark.registerCompiler``)
* plugin that executes certain actions when contracts are deployed (``embark.events.on``)
* plugin that registers a service in embark (``embark.registerServiceCheck``)
* plugin that adds support to upload the dapp somewhere (``embark.registerUploadCommand``)
* plugin that extends EmbarkJS (``embark.addCodeToEmbarkJS``, ``embark.addProviderInit``)

