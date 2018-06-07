title: Testing
---

Testing Ethereum Contracts
==========================

## How to

You can run specs with ``embark test``, it will run all the test files under
``test/``. You can run a specific test file with `embark test <path/test_filename.js>`

Embark includes a testing lib to fastly run & test your contracts in a
EVM.

```Javascript
    // test/simple_storage_spec.js
    /*global contract, config, it, embark, assert, web3*/
    const SimpleStorage = embark.require('Embark/contracts/SimpleStorage');
    let accounts;
    
    config({
      contracts: {
        "SimpleStorage": {
          args: [100],
          onDeploy: ["SimpleStorage.methods.setRegistar(web3.eth.defaultAccount).send()"]
        }
      }
    }, (err, theAccounts) => {
      accounts = theAccounts;
    });
    
    contract("SimpleStorage", function () {
      this.timeout(0);
    
      it("should set constructor value", async function () {
        let result = await SimpleStorage.methods.storedData().call();
        assert.strictEqual(parseInt(result, 10), 100);
      });
    
      it("set storage value", async function () {
        await SimpleStorage.methods.set(150).send();
        let result = await SimpleStorage.methods.get().call();
        assert.strictEqual(parseInt(result, 10), 499650);
      });
    });

```

## Configuring accounts

You can use the same account settings that you would use in [contracts.json](https://embark.status.im/docs/contracts.html#Using-accounts-in-a-wallet)

That way, you can use a specific account for your test. 

You can even optionally set the balance of each account using real units eg: "5eth", "125gwei", "500 szabo".
If the unit is not specified, Embark will assume weis.

```Javascript
    // test/simple_storage_spec.js

    config({
    "deployment": {
        "accounts": [
          {
            "privateKey": "your_private_key",
            balance: "600000Kwei"
          },
          {
            "privateKeyFile": "path/to/file", // You can put more than one key, separated by , or ;
            balance: "42 shannon"
          },
          {
            "mnemonic": "12 word mnemonic",
            "addressIndex": "0", // Optionnal. The index to start getting the address
            "numAddresses": "1", // Optionnal. The number of addresses to get
            "hdpath": "m/44'/60'/0'/0/" // Optionnal. HD derivation path
          }
        ]
      }
    });

    describe("SimpleStorage", function() {
      
    });
```

## Configuring node

By default Embark will use an internal VM to run the tests, however you can also
specify a node to connect to and run the tests there, just like in contracts.json.

```Javascript
  // test/simple_storage_spec.js

    config({
      deployment: {
        "host": "localhost",
         "port": 8545,
         "type": "rpc"
      }
    });

    describe("SimpleStorage", function() {
    });
```

## Accessing accounts

The callback used in the function ``config`` will let you access the accounts configured in the EVM. 
You can assign them to a variable and use them in your tests. 
That callback is optional. If you do not need the accounts, you do not have to supply it.

```Javascript
    let accounts;
    config({
      contracts: {
        "SimpleStorage": {
          args: [100]
        }
      }
    }, (err, theAccounts) => {
      accounts = theAccounts;
    });
```

## Creating contract instances in your tests

// TODO Change this section after it is possible to do that

Embark handles the deployment of your contracts through the function ``config``. 
However you can use ``web3.eth.contract`` for creating instances of your contracts manually.

```Javascript
    var simpleStorageJson = require('../dist/contracts/SimpleStorage.json');
    var accountArr;
    var simpleStorage;
    
    describe("SimpleStorage", function() {
      this.timeout(0);
      before(function(done) {
        EmbarkSpec.deployAll({}, (accounts) => {
          accountArr = accounts;
          done();
        });
      });
    
      it("should deploy a contract instance", function(done) {
        var simpleStorageContract = new web3.eth.Contract(simpleStorageJson.abi);
        simpleStorageContract.deploy({data: simpleStorageJson.code, arguments: [100]})
          .send({from: accountArr[0], gas: 5000000, gasPrice: 1})
          .then(function(contractInstance){
            simpleStorage = contractInstance;
            simpleStorage.setProvider(web3.currentProvider);
            assert(simpleStorage.options.address != null);
           })
          .finally(done);
      });
    });
```

