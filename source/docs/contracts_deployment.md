title: Accounts & Deplyoment
---

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

You can use your own account in a wallet which will then be used for the contract deploy, for example:

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "testnet": {
      "deployment": {
        <mark class="highlight-inline">"accounts": [
          {
            // If privateKey is set to `random`, will generate a random account (can be useful for tests)
            "privateKey": "your_private_key"
          },
          {
            "privateKeyFile": "path/to/file", // Either a keystore or a list of keys, separated by , or ;
            "password": "passwordForTheKeystore" // Needed to decrypt the keystore file
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

### Node accounts + user accounts

If you still wish to use your Ethereum node's account(s) along with your custom accounts, just use the following:

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "testnet": {
      "deployment": {
        "accounts": [
          <mark class="highlight-inline">{
            "nodeAccounts": true
          }</mark>,
          {
            // One of your own account
          }
        ]
      }
  }
}
</code></pre>

The order in the accounts array is important. This means that using `nodeAccounts` first, as above, will set the node's account as the `defaultAccount` for deployment.

#### Deploying to Mainnet

There are special security considerations to have when deploying to production. Chiefly, no private keys, private key files or mnemonics should be present in source control. Instead, we recommend using environment variables to pass those values in, like so:

<pre><code class="javascript">// config/contracts.js
const secrets = require('secrets.json'); // should NOT be in source control

module.exports = {
  "mainnet": {
      "deployment": {
        <mark class="highlight-inline">"accounts": [
          {
            "privateKeyFile": secrets.privateKeyFilePath,
            "password": secrets.password
          },
          {
            "mnemonic": process.env.DAPP_MNEMONIC, // An environment variable is also possible
            "addressIndex": "0", // Optional. The index to start getting the address
            "numAddresses": "1", // Optional. The number of addresses to get
            "hdpath": "m/44'/60'/0'/0/" // Optional. HD derivation path
          }
        ]
      }</mark>
  }
}
</code></pre>

#### Account balance (dev)
When in development, you can also specify the balance of each account. Here's how you do it:

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

You can specify the balance using a unit such as "5 ether" or "200 finney". If no unit is specified the value will be in wei.

You can also connect to a remote Infura.io blockchain node as per instructions below. The following specifies the configuration for the web3 provider, not the blockchain node configuration itself.

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

### Using your accounts in arguments

You can specify an account the same way you would a contract to set the account's address as a contract argument.

<pre><code class="javascript">// config/contracts.js
module.exports = {
  "development": {
    "contracts": {
      "MyContractThatNeedsAccountAddresses": {
        "args": [
          "<mark class="highlight-inline">$accounts[0]", // Sets the first accounts's address as an argument
          "$accounts[4]" // Same thing for the 5th account (account needs to exist)</mark>
        ]
      }
    }
  }
}
</code></pre>

## Testnet and Mainnet API Endpoints

Alchemy Insights are offering a preview of their API that we can use for deploying to and interacting with our contracts on testnet (Rinkeby, Ropsten, and Kovan) and mainnet. The following endpoints are available for our use.

{% note info No websockets support %}
Please note that these endpoints currently do not support websockets. There are plans to support websockets in the future.

If your dApp relies on websockets use, please use another API endpoint such as Infura.
{% endnote %}

#### Alchemy Insights Endpoints
<pre><code class="javascript">
Mainnet: https://eth-mainnet.alchemyapi.io/jsonrpc/8a9fRmi8wx5BrSOOqKa6-3nFHMHYRvmH
Kovan: https://eth-kovan.alchemyapi.io/jsonrpc/8a9fRmi8wx5BrSOOqKa6-3nFHMHYRvmH
Rinkeby: https://eth-rinkeby.alchemyapi.io/jsonrpc/8a9fRmi8wx5BrSOOqKa6-3nFHMHYRvmH
Ropsten: https://eth-ropsten.alchemyapi.io/jsonrpc/8a9fRmi8wx5BrSOOqKa6-3nFHMHYRvmH
</code></pre>
