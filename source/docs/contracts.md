title: Contracts
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
You can also specify interfaces and choose to not deploy contracts (for e.g in case they are interfaces)

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

You can deploy many instances of the same contract. e.g

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

### Deployer Account

You can specify which Account you want to deploy a contract from. This can be specified using "from" or "fromIndex" parameters.

| `from` - should be account address string.
| `fromIndex` - should be index in accounts array as retrieved by `web3.eth.getAccounts()`.

If both `from` and `fromIndex` are specified, the `from` field will be used.

Example:

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "contracts": {
      "Currency": {
        "deploy": true,
        <mark class="highlight-inline">"from": '0xfeedaa0e295b09cd84d6ea2cce390eb443bcfdfc',</mark>
        "args": [
          100
        ]
      },
      "MyStorage": {
        <mark class="highlight-inline">"fromIndex": 0,</mark>
        "args": [
          "initial string"
        ]
      },
    }
  }
  // ....
}
</code></pre>

### Using accounts in a wallet

You can use your own account in a wallet which will then be used for the contract deploy, for example.

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "testnet": {
      "deployment": {
        <mark class="highlight-inline">"accounts": [
          {
            "privateKey": "your_private_key"
          },
          {
            "privateKeyFile": "path/to/file" // You can put more than one key, separated by , or ;
          },
          {
            "mnemonic": "12 word mnemonic",
            "addressIndex": "0", // Optional. The index to start getting the address
            "numAddresses": "1", // Optional. The number of addresses to get
            "hdpath": "m/44'/60'/0'/0/" // Optional. HD derivation path
          }
        ]
      }</mark>
  }
}
</code></pre>

When in development you can also specify the balance of each account as well, for e.g

<pre><code class="javascript">module.exports = {
  "development": {
      "deployment": {
        "accounts": [
          {
            "mnemonic": "12 word mnemonic",
            <mark class="highlight-inline">"balance": "5 ether"</mark>
          }
        ]
      }
  }
}
</code></pre>

You can specify the balance using a unit as "5 ether" of "200 finney", if no unit is specified the value will be in wei.

If you are using Infura.io to connect to a blockchain node, this is also possible to connect to from Embark like so. The following specifies the configuration for the web3 provider, not the blockchain node configuration itself.

<pre><code class="javascript">module.exports = {
  testnet: {
    deployment:{
      accounts: [
        {
         // your accounts here, see above for details
        }
      ],
      <mark class="highlight-inline">host: "rinkeby.infura.io/INFURA_TOKEN_HERE",
      port: false,
      protocol: 'https',
      type: "rpc"</mark>
    }
  }
}
</code></pre>

### Static Addresses

Contracts addresses can be defined, If an address is defined the contract wouldn't be deployed but its defined address will be used instead.

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

| `onDeploy` - should be an array of javascript instructions that will be evaluated and executed

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

| `afterDeploy` - should be an array of javascript instructions that will be evaluated and executed

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

By default embark will look for the contracts inside the folder defined in "contracts"` property in embark.json.
However it's possible to specify the contract filepath:

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
        <mark class="highlight-inline">"file": "https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/ownership/Ownable.sol"</mark>
      }
    }
  }
}
</code></pre>

### Specify contract file from package

It's also possible to specify a contract file from a npm package:

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "gas": "auto",
    "contracts": {
      "ERC20": {
        <mark class="highlight-inline">"file": "zeppelin-solidity/contracts/token/ERC20/ERC20.sol"</mark>
      }
    }
  }
}
</code></pre>

### Importing files in contracts

If using solidity it's also possible to directly import contract files inside the dapp from folders that are not explicity defined in the "contracts" propery of embark.json.

<pre><code class="solidity">import "another_folder/another_test.sol";</code></pre>

You can also import a contract file from a npm package:

<pre><code class="solidity">import "zeppelin-solidity/contracts/ownership/Ownable.sol";</code></pre>

You can even use files directly from Git, Github or directly from HTTP(S):

<pre><code class="solidity">import "git://github.com/status/contracts/contracts/identity/ERC725.sol#develop";
import "github.com/status/contracts/contracts/identity/ERC725.sol";
import "https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/ownership/Ownable.sol";
</code></pre>

