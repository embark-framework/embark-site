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

