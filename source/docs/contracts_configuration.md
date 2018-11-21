title: Contracts Configuration
---

### Basic Contract Configuration

You can specify for each contract and environment its gas costs (in wei) and arguments:

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "gas": "auto",
    "contracts": {
      "SimpleStorage": {
        "args": [
          100
        ],
        "gas": 800000,
        "gasPrice": 5
      }
    }
  }
}
</code></pre>

If you prefer it's also possible to specify the contract arguments by their variable name instead of a list:

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "contracts": {
      "SimpleStorage": {
        <mark class="highlight-inline">"args": {
          "initial_value": 100
        }</mark>
      }
    }
  }
}
</code></pre>

### Specifying Contract Dependencies

If you are using multiple contracts, you can pass a reference to another contract as ``$ContractName``, Embark will automatically replace this with the correct address for the contract.
You can also specify interfaces and choose to not deploy contracts (e.g. in case they are interfaces)

<pre><code class="javascript">// config/contracts.js
module.exports = {
  ...
  "development": {
    "contracts": {
      "SimpleStorage": {
        "args": [
          100,
          <mark class="highlight-inline">"$MyStorage"</mark>
        ]
      },
      "MyStorage": {
        "args": [
          "initial string"
        ]
      },
      "MyMainContract": {
        "args": [
          <mark class="highlight-inline">"$SimpleStorage"</mark>
        ]
      },
      "MyContractInteface": {
        "deploy": false
      }
    }
  }
  ...
}
</code></pre>

### Multiple Instances

You can deploy many instances of the same contract. E.g.

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "contracts": {
      "Currency": {
        "deploy": false,
        "args": [
          100
        ]
      },
      "Usd": {
        <mark class="highlight-inline">"instanceOf": "Currency",</mark>
        "args": [
          200
        ]
      },
      "MyCoin": {
        <mark class="highlight-inline">"instanceOf": "Currency",</mark>
        "args": [
          200
        ]
      }
    }
  }
}
</code></pre>

### Static Addresses

Contracts' addresses can be defined. If an address is defined the contract wouldn't be deployed but its defined address will be used instead.

<pre><code class="javascript">// config/contracts.js
module.exports = {
  // ...
  "development": {
    "contracts": {
      "UserStorage": {
        <mark class="highlight-inline">"address": "0x123456"</mark>
      },
      "UserManagement": {
        "args": [
          "$UserStorage"
        ]
      }
    }
  }
  // ...
}
</code></pre>


### Specify contract file

By default embark will look for the contracts inside the folder defined in the `"contracts"` property in `embark.json`.
However, it's possible to specify the contract filepath:

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "gas": "auto",
    "contracts": {
      "SimpleStorage": {
        <mark class="highlight-inline">"file": "./some_folder/simple_storage.sol",</mark>
        "args": [
          100
        ]
      }
    }
  }
}
</code></pre>

You can even specify files on Git, Github or over HTTP(S):
<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "contracts": {
      "ERC725": {
        <mark class="highlight-inline">"file": "git://github.com/status/contracts/contracts/identity/ERC725.sol#develop"</mark>
      },
      "ERC725": {
        <mark class="highlight-inline">"file": "github.com/status/contracts/contracts/identity/ERC725.sol"</mark>
      },
      "Ownable": {
        <mark class="highlight-inline">"file": "https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/ownership/Ownable.sol"</mark>
      }
    }
  }
}
</code></pre>

### Specify contract file from package

It's also possible to specify a contract file from an npm package:

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "gas": "auto",
    "contracts": {
      "ERC20": {
        <mark class="highlight-inline">"file": "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol"</mark>
      }
    }
  }
}
</code></pre>

### Deployment tracking

Embark's contract deployment mechanism prevents deployment if contract code was already deployed.
It is possible to disable this feature for a given contract by setting `track` configuration field to `false`. This way the contract will be always deployed.

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "contracts": {
      "ERC20": {
        <mark class="highlight-inline">"track": false</mark>
      },
      "Manager": {
      },
    }
  }
}
</code></pre>

### Solc compiler options
 You can specify some options for the solidity compiler in `embark.json`
You can find more details here: https://solidity.readthedocs.io/en/v0.4.24/using-the-compiler.html?highlight=optimize
 <pre><code class="json">// embark.json
{
  "options": {
    "solc": {
      "optimize": true, // When set to true, will optimize the contracts to lower their size
      "optimize-runs": 200 // The lower the number, the higher the optimization
    }
  }
}
</code></pre>

## Deployment life cycle hooks

Sometimes we want to execute certain logic when Smart Contracts are being deployed or after all of them have been deployed. In other cases, we'd even like to control whether a Smart Contract should be deployed in the first place. For those scenarios, Embark lets us define the deployment life cycle hooks `deployIf`, `onDeploy` and `afterDeploy`.

Life cycle hooks have access to a `dependencies` object that comes with instances of all Smart Contracts that are defined as dependency of the hooks using the `deps` property of the Smart Contract in question, and the Smart Contract itself. In addition to all relevant Smart Contract instances, this object also exposes the current `web3` instance as shown in the examples below.

### Conditional Deployment with `deployIf`

We can specify a condition that decides whether a contract should be deployed by using the `deployIf` life cycle hook. `deployIf` is a function that either returns a promise or is created using `async/await` syntax and has to resolve to a boolean value. If the resolve value is `true`, the Smart Contract in question will be deployed. If it's `false`, Embark will skip deploying the Smart Contract in question.

<pre><code class="javascript">// config/contracts.js
module.exports = {
  development: {
    contracts: {
      ERC20: {
        <mark class="highlight-inline">deployIf: async (dependencies) => {
          return await dependencies.contracts.Manager.methods.isUpdateApproved().call();
        }</mark>,
        deps: ['Manager']
      },
      Manager: {...},
    }
  }
}
</code></pre>

Notice how `dependencies.contracts` gives access to the `Manager` contract instance. This however, is only possible because `Manager` has been defined as dependency of `ERC20` using the `deps` property. If we're using a Node version that doesn't support async/await, the same can be achieved using promises like this (web3 APIs already return promises):

<pre><code class="javascript">...
ERC20: {
  <mark class="highlight-inline">deployIf: (dependencies) => {
    return dependencies.contracts.Manager.methods.isUpdateApproved().call();
  }</mark>,
  deps: ['Manager']
},
...
</code></pre>

### `onDeploy` Life cycle hook

We can specify the `onDeploy` life cycle hook to execute code, right after a contract has been deployed. Just like `deployIf` and `afterDeploy`, `onDeploy` is a function that has access to the Smart Contract's dependencies defined in its `deps` property. The following example executes `SimpleStorage`'s `set()` method, once deployed.

<pre><code class="javascript">// config/contracts.js
module.exports = {
  development: {
    contracts: {
      SimpleStorage: {
        args: [100],
        <mark class="highlight-inline">onDeploy: async (dependencies) => {
					const simpleStorage = dependencies.contracts.SimpleStorage
          const web3 = dependences.web3;
          
          await simpleStorage.methods.setRegistar(web3.eth.defaultAccount).send()
          await simpleStorage.methods.set(150).send();
        }</mark>
      }
    }
  }
}
</code></pre>

As mentioned above, every life cycle hook works with plain promises as well:

<pre><code class="javascript">...
SimpleStorage: {
  args: [100],
  <mark class="highlight-inline">onDeploy: (dependencies) => {
    const simpleStorage = dependencies.contracts.SimpleStorage
    const web3 = dependences.web3;

    return simpleStorage.methods
      .setRegistar(web3.eth.defaultAccount).send()
      .then(_ => simpleStorage.methods.set(150).send());
  }</mark>
}
...
</code></pre>

### `afterDeploy` life cycle hook

If we want to execute code once all of our Smart Contracts have been deployed, Embark has got us covered with the `afterDeploy` life cycle hook. The same rules apply here. `afterDeploy` has access to all deployed contract instances through the `dependencies` object.

<pre><code class="javascript">// config/contracts.js
module.exports = {
  development: {
    contracts: {
      SimpleStorage: {
        args: [100]
      }
    }
    <mark class="highlight-inline">afterDeploy: (dependencies) => {
      dependencies.contracts.SimpleStorage.methods.set(150).send();
    }</mark>
  }
}
</code></pre>

{% note info A note on Life cycle hook string syntax %}
In older versions of Embark, life cycle hooks have been defined as an array of strings. This is due historical reasons where configuration files used to be JSON files that don't support functions.

The examples above can be therefore written as:

<pre><code class="javascript">afterDeploy: ['SimpleStorage.methods.set(150).send()']
onDeploy: ['SimpleStorage.methods.set(150).send()']
deployIf: 'await Manager.methods.isUpdateApproved()'
</code></pre>


This string syntax is still supported but will be deprecated and likely be removed in future versions of Embark.
{% endnote %}

