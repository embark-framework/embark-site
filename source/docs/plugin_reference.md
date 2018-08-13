title: Plugin Reference
---

### embark.pluginConfig

Object containing the config for the plugin specified in embark.json, for e.g with:

```Javascript
    "plugins": {
      "embark-babel": { "files": ["**/*.js", "!**/jquery.min.js"], "presets": ["es2015", "react"] }
    }
```

``embark.pluginConfig`` will contain ``{ "files": ["**/*.js", "!**/jquery.min.js"], "presets": ["es2015", "react"] }``

### embark.registerPipeline(matchingFiles, callback(options))

This call will return the content of the current asset file so the plugin can transform it in some way. Typically this is used to implement pipeline plugins such as Babel, JSX, sass to css, etc..

``matchingFiles`` is an array of matching files the plugin should be called for e.g [``**/*.js``, ``!vendor/jquery.js``] matches all javascript files except vendor/jquery.js

options available:
 * targetFile - filename to be generated
 * source - content of the file

expected return: ``string``

```Javascript
    var babel = require("babel-core");
    require("babel-preset-react");

    module.exports = function(embark) {
        embark.registerPipeline(["**/*.js", "**/*.jsx"], function(options) {
          return babel.transform(options.source, {minified: true, presets: ['react']}).code;
        });
    }
```

### embark.registerContractConfiguration(contractsConfig)

This call is used to specify a configure of one or more contracts in one or
several environments. This is useful for specifying the different configurations
a contract might have depending on the enviroment. For instance in the code
bellow, the ``DGDToken`` contract code will redeployed with the arguments
``100`` in any environment, except for the livenet since it's already deployed
there at a particular address.

Typically this call is used in combination with ``embark.addContractFile``

``contractsConfig`` is an object in the same structure as the one found in the
contracts configuration at ``config/contracts.json``. The users own
configuration will be merged with the one specified in the plugins.

```Javascript
    module.exports = function(embark) {
        embark.registerContractConfiguration({
          "default": {
            "contracts": {
              "DGDToken": {
                "args": [
                  100
                ]
              }
            }
          },
          "livenet": {
            "contracts": {
              "DGDToken": {
                "address": "0xe0b7927c4af23765cb51314a0e0521a9645f0e2a"
              }
            }
          }
        });
    }
```

### embark.addContractFile(file)

Typically this call is used in combination with ``embark.registerContractConfiguration``. If you want to make the contract available but not automatically deployed without the user specifying so you can use ``registerContractConfiguration`` to set the contract config to ``deploy: false``, this is particularly useful for when the user is meant to extend the contract being given (e.g ``contract MyToken is StandardToken``)

``file`` is the contract file to add to embark, the path should relative to the plugin.

```Javascript
    module.exports = function(embark) {
        embark.addContractFile("./DGDToken.sol");
    }
```

### embark.addFileToPipeline(file, options)

This call is used to add a file to the pipeline so it's included with the dapp on the client side.

``file`` is the file to add to the pipeline, the path should relative to the plugin.

``intendedPath`` is the intended path outside of the plugin

``options`` available:
 * skipPipeline - If true it will not apply transformations to the file. For
   example if you have a babel plugin to transform es6 code or a minifier plugin, setting this to
   true will not apply the plugin on this file.

```Javascript
    module.exports = function(embark) {
        embark.addFileToPipeline("./jquery.js", {skipPipeline: true});
    }
```

### embark.registerBeforeDeploy(callback(options), [callback])

This call can be used to add handler to process contract code after it was generated, but immediately before it is going to be deployed.
It is useful to replace placeholders with dynamic values.

options available:
 * embarkDeploy - instance of Deploy class. Has following fields: web3, contractsManager, logger, env, chainConfig, gasLimit.
 * pluginConfig - plugin configuration object from embark.json
 * deploymentAccount - address of account which will be used to deploy this contract
 * contract - contract object.
 * callback - callback function that handler must call with result object as the only argument. Result object must have field contractCode with (un)modified code from contract.code

You can use the callback argument instead of the callback option if you prefer. It needs the same result object.

expected return: ignored

example:

```Javascript
    module.exports = function(embark) {
      embark.registerBeforeDeploy(function(options) {
        var code = options.contract.code.replace(/deaddeaddeaddeaddeaddeaddeaddeaddeaddead/ig, 'c0dec0dec0dec0dec0dec0dec0dec0dec0dec0de');
        options.callback({ contractCode: code });
        return; // ignored
      });
    }
```

### embark.registerClientWeb3Provider(callback(options))

This call can be used to override the default web3 object generation in the dapp. it's useful if you want to add a plugin to interact with services like http://infura.io or if you want to use your own web3.js library extension.

options available:
 * rpcHost - configured rpc Host to connect to
 * rpcPort - configured rpc Port to connect to
 * blockchainConfig - object containing the full blockchain configuration for the current environment

expected return: ``string``

example:

```Javascript
    module.exports = function(embark) {
        embark.registerClientWeb3Provider(function(options) {
            return "web3 = new Web3(new Web3.providers.HttpProvider('http://" + options.rpcHost + ":" + options.rpcPort + "'));";
        });
    }
```


### embark.registerContractsGeneration(callback(options))

By default Embark will use EmbarkJS to declare contracts in the dapp. You can override and use your own client side library.

options available:
  * contracts - Hash of objects containing all the deployed contracts. (key: contractName, value: contract object)
  * abiDefinition
  * code
  * deployedAddress
  * gasEstimates
  * gas
  * gasPrice
  * runtimeByteCode

expected return: ``string``

```Javascript
    embark.registerContractsGeneration(function (options) {
        const contractGenerations = [];
        Object.keys(options.contracts).map(className => {
          const contract = options.contracts[className];
          const abi = JSON.stringify(contract.abiDefinition);
    
          contractGenerations.push(`${className} = web3.eth.contract('${abi}').at('${contract.deployedAddress}')`);
        });
        return contractGenerations.join('\n');
      });
```

### embark.registerConsoleCommand(callback(options))

This call is used to extend the console with custom commands.

Expected result: an `object` with 2 functions:
* `match`: return a boolean, `true` if the command must be processed.
* `process`: the callback expects 2 arguments, the `error` (`null` if none) 
and the result as a `string` (output to print in console)

```Javascript
    module.exports = function(embark) {
        embark.registerConsoleCommand(function(cmd, options) {
          return {
            match: () => cmd === "hello",
            process: (callback) => callback(null, "hello there!")
          };
        });
    }
```

### embark.registerCompiler(extension, callback(contractFiles, doneCallback))

Expected doneCallback arguments: ``err`` and  ``hash`` of compiled contracts

  * Hash of objects containing the compiled contracts. (key: contractName, value: contract object)
      * code - [required] contract bytecode (string)      
      * abiDefinition - [required] contract abi (array of objects)
        * e.g ``[{"constant":true,"inputs":[],"name":"storedData","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"}, etc...``
      * runtimeBytecode - [optionnal] contract runtimeBytecode (string)
      * gasEstimates - [optionnal] gas estimates for constructor and methods (hash)
        * e.g ``{"creation":[20131,38200],"external":{"get()":269,"set(uint256)":20163,"storedData()":224},"internal":{}}``
      * functionHashes - [optionnal] object with methods and their corresponding hash identifier (hash)
        * e.g ``{"get()":"6d4ce63c","set(uint256)":"60fe47b1","storedData()":"2a1afcd9"}``


Below a possible implementation of a solcjs plugin:

```Javascript
    var solc = require('solc');

    module.exports = function(embark) {
        embark.registerCompiler(".sol", function(contractFiles, cb) {
          // prepare input for solc
          var input = {};
          for (var i = 0; i < contractFiles.length; i++) {
            var filename = contractFiles[i].filename.replace('app/contracts/','');
            input[filename] = contractFiles[i].content.toString();
          }

          // compile files
          var output = solc.compile({sources: input}, 1);

          // generate the compileObject expected by embark
          var json = output.contracts;
          var compiled_object = {};
          for (var className in json) {
            var contract = json[className];

            compiled_object[className] = {};
            compiled_object[className].code            = contract.bytecode;
            compiled_object[className].runtimeBytecode = contract.runtimeBytecode;
            compiled_object[className].gasEstimates    = contract.gasEstimates;
            compiled_object[className].functionHashes  = contract.functionHashes;
            compiled_object[className].abiDefinition   = JSON.parse(contract.interface);
          }

          cb(null, compiled_object);
        });
    }
```

### embark.logger

To print messages to the embark log is it better to use ``embark.logger``
instead of ``console``.

e.g ``embark.logger.info("hello")``

### embark.events.on(eventName, callback(*args))

This call is used to listen and react to events that happen in Embark such as contract deployment

* eventName - name of event to listen to
   * available events:
      * "contractsDeployed" - triggered when contracts have been deployed
      * "file-add", "file-change", "file-remove", "file-event" - triggered on a file change, args is (filetype, path)
      * "outputDone" - triggered when dapp is (re)generated
      * "firstDeploymentDone" - triggered when the dapp is deployed and generated for the first time
      * "check:backOnline:serviceName" - triggered when the service with ``serviceName`` comes back online
      * "check:wentOffline:serviceName" - triggered when the service with ``serviceName`` goes offline
      * "log" - triggered on a log, args is (logLevel, logMsg)
      * "contractsState" - list of contracts, their deployment status, address, etc..
      * "servicesState" - list of services and their state
      * "exit": - triggered when embark is terminating
      * "deploy:contract:deployed": - triggered when a contract is deployed, the callback will contain the contract object
      * "deploy:contract:undeployed": - triggered when a contract was not deployed (typically because there is no need), the callback will contain the contract object
      * "deploy:contract:error": - triggered when a contract couldn't be deployed due to an error, the callback will contain the contract object
      * "deploy:contract:receipt": - triggered on a contract deployment (succefull or not), the callback will contain the resulting receipt
      * "contractsState": - triggered often, whenever there are changes to contracts, the callback will contain an object containing the contract names, address and state, etc..
      * "deploy:beforeAll": - triggered before contract deployment starts
      * "contracts:deploy:afterAll": - triggered after contract deployment starts

```Javascript
    module.exports = function(embark) {
        embark.events.on("contractsDeployed", function() {
          embark.logger.info("plugin says: your contracts have been deployed");
        });
        embark.events.on("file-change", function(filetype, path) {
          if (type === 'contract') {
            embark.logger.info("plugin says: you just changed the contract at " + path);
          }
        });
    }
```

### embark.events.request(requestName, callback(*args))

This call is used to request a certain resource from Embark

* requestName - name of request to listen to
   * available requests:
     * ("deploy:contract", contractObj) - deploys a particular contract through embark
     * ("runcode:eval", code) - runs js code in the Embark engine.
     * ("runcode:register", cmdName, cmdObj) - 'registers' a variable cmdName to correspond to a js object cmdObj (note: this should be done thourgh an emit);
     * ("contracts:list") - returns a list a callback containing (err, contractList) containing a collection of available contracts
     * ("compiler:contracts", contractFiles) - requests embark to compile a list of files, will return a compiled object in the callback
     * ("services:register", serviceName, checkCallback) - requests embark to register a service, it will execute checkCallback every 5 seconds, the callback should return an object containing the service name and status (See embark.registerServiceCheck)
     * ("console:command", cmd) - execute a command in the console

```Javascript
    module.exports = function(embark) {
        embark.events.request("code", function(code) {
          // Do something with the code
        });
    }
```

### embark.registerServiceCheck(serviceName, callback({name, status}), time)

This call is used to register a service in embark so it's periodically checked.
It will be displayed in the Embark Dashboard, and will also trigger events such as ``check:backOnline:yourServiceName`` and ``check:backOffline:yourServiceName``

* serviceName - name of service (string)
* callback:
  * "name" - name/text to display (string)
  * "status" - status of the service (string, "on" or "off" or "warn")
* time (optional) - ms interval to call the callback (default: 5000 ms)

```Javascript
    module.exports = function(embark) {
        embark.registerServiceCheck("MyServer", function(cb) {
          if (myServiceOnline()) {
            return cb({name: "MyServer Online", status: "on"});
          } else {
            return cb({name: "MyServer Offline", status: "off"});
          }
        });
    }
```

### embark.registerUploadCommand(cmdName, callback)

This call is used to add a new cmd to ``embark upload`` to upload the dapp to
a new storage service. In the example, `run` doesn't exist. You need to import a library that runs shell commands like [shelljs](https://www.npmjs.com/package/shelljs)

```Javascript
    module.exports = function(embark) {
        embark.registerUploadCommand("ipfs", function() {
          run("ipfs add -r dist/");
        });
    }
```

### embark.addCodeToEmbarkJS(code)

This call is used to add code to the embark.js library. It's typically used to
extend it with new functionality, new storage providers, new communication
providers, etc..

```Javascript
    module.exports = function(embark) {
        embark.addCodeToEmbarkJS("alert('hello world!')");
    }
```

### embark.addProviderInit(providerType, code, initCondition(config))

This call is used to add code to be executed in the initialization under the
condition that ``initCondition`` returns true. For example this can be used to
set the storage provider of EmbarkJS to ipfs if ipfs is enabled as a provider in
the config

* providerType - type of provider (string, "storage" or "communication")
* code - code to add (string)
* callback:
  * "config" - config of the ``providerType``

```Javascript
    module.exports = function(embark) {
        let code = "\nEmbarkJS.Storage.setProvider('ipfs')";
        embark.addProviderInit('storage', code, (storageConfig) => {
          return (storageConfig.provider === 'ipfs' && storageConfig.enabled === true);
        });
    }
```

### embark.registerImportFile(importName, importLocation)

This call is used so the plugin can make a certain file available as a library
to a user

```Javascript
    var path = require('path')

    module.exports = function(embark) {
        embark.registerImportFile("my-lib", path.join(__dirname, "my-lib.js"));
    }
```

