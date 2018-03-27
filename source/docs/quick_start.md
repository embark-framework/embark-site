title: Quick Start
---

### Create demo app

```Bash
$ embark demo
$ cd embark_demo
```

### Start a blockchain node

You can run a REAL ethereum node for development purposes:

```Bash
$ embark blockchain
```

Alternatively, to use an ethereum rpc simulator simply run:

```Bash
$ embark simulator
```

By default Embark blockchain will mine a minimum amount of ether and will only mine when new transactions come in.

### Start Embark

Then, in another command line:

```Bash
$ embark run
```

This will open up the embark Dashboard

![Dashboard](http://i.imgur.com/s4OQZpu.jpg)

The dashboard will tell you the state of your contracts, the environment you are using, and what Embark is doing at the moment.

**available services**

Available Services will display the services available to your dapp in green. If a service is down, then it will be displayed in red.

**logs and console**

There is a console at the bottom which can be used to interact with contracts or with Embark itself. Type ``help`` to see a list of available commands.  More commands will be added with each version of Embark.

Embark will then compile & deploy the contracts, update their JS bindings and deploy your DApp to a local server at http://localhost:8000

{% note for without the dashboard %}
if you prefer to only see the logs, you can disable the dashboard with the nodashboard option ``embark run --nodashboard``
{% endnote %}

Note that if you update your code, it will automatically be re-deployed, contracts included. There is no need to restart embark, refreshing the page on the browser will do.

### Interacting with contracts in Javascript

Embark will automatically take care of deployment for you and set all
needed JS bindings. For example, the contract below:

```Javascript
    # app/contracts/simple_storage.sol
    contract SimpleStorage {
      uint public storedData;

      function SimpleStorage(uint initialValue) {
        storedData = initialValue;
      }

      function set(uint x) {
        storedData = x;
      }
      function get() constant returns (uint retVal) {
        return storedData;
      }
    }
```

Will automatically be available in Javascript as:

```Javascript
    # app/js/index.js
    import SimpleStorage from 'Embark/contracts/SimpleStorage';

    SimpleStorage.methods.set(100).send();
    SimpleStorage.methods.get().call().then(function(value) { console.log(value) });
    SimpleStorage.methods.storedData().call().then(function(value) { console.log(value) });
```

### TO ADD

browser screenshot, guide through

js code walkthrough

