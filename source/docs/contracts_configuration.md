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

### onDeploy Actions

You can specify actions to do after the deployment of a contract using the "onDeploy" parameter.

| `onDeploy` - should be an array of JavaScript instructions that will be evaluated and executed

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "gas": "auto",
    "contracts": {
      "SimpleStorage": {
        "args": [
          100
        ],
        <mark class="highlight-inline">"onDeploy": ["SimpleStorage.methods.set(150).send()"]</mark>
      }
    }
  }
}
</code></pre>

### afterDeploy Actions

You can specify actions to do after ALL contracts have been deployed by using the "afterDeploy" parameter.

| `afterDeploy` - should be an array of JavaScript instructions that will be evaluated and executed

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "gas": "auto",
    "contracts": {
      "SimpleStorage": {
        "args": [
          100
        ]
      },
      <mark class="highlight-inline">"afterDeploy": [
        "SimpleStorage.methods.set(150).send()"
      ]</mark>
    }
  }
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
