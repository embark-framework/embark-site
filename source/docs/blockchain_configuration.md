title: Blockchain configuration
---

When in development phase, it is necessary to use a local Ethereum node to deploy our contracts to, either using a simulator or client like Geth or Parity.

To set this node, Embark looks at `blockchain.js`, which by default is at `config/blockchain.js`.

It is a complex file, but Embark, when using the `embark new` and `embark demo` command, creates a default `blockchain.js` file for you that contains all the basic parameters for you to start a Geth node or a Ganache simulator.

## Common Parameters

Here are the common parameters:

<pre><code class="javascript">module.exports = {
  default: {
    enabled: true,
    rpcHost: "localhost",
    rpcPort: 8545,
    rpcCorsDomain: "auto",
    wsRPC: true,
    wsOrigins: "auto",
    wsHost: "localhost", 
    wsPort: 8546
  },
  development: {
    ethereumClientName: "geth",
    ethereumClientBin: "geth",
    datadir: ".embark/development/datadir",
    networkType: "custom",
    networkId: 1337,
    isDev: true,
    nodiscover: true,
    maxpeers: 0,
    proxy: true,
    targetGasLimit: 8000000
  }
}
</code></pre>

As with `contracts.js`, this config contains environments that help configuring certain parameters differently depending of the environment. You can read more about [environments here](https://embark.status.im/docs/environments.html).

### Parameter descriptions

- **enabled**: Whether or not to spawn an Ethereum node
- **rpcHost**: Host the RPC server listens to
- **rpcPort**: Port the RPC server listens to
- **rpcCorsDomain**: The CORS domains the node accepts
  - By using **"auto"`, Embark checks the other configurations to set the CORS domains. This only adds the required domains.
- **wsRPC**: Whether or not to enable the Websocket server
- **wsOrigins**: Same as `rpcCorsDomain`, but for the Websocket server
- **wsHost**: Same as `rpcHost`, but for the Websocket server
- **wsPort**: Same as `rpcPort`, but for the Websocket server
- **ethereumClientName**: Client to use for the Ethereum node. Currently supported: `geth` and `parity`
- **ethereumClientBin**: Path to the client binary. By default, Embark uses the client name as an executable (if it is in the PATH)
- **datadir**: Directory where to put the Node's data (eg: keystores)
- **networkType**: Can be: `testnet`, `rinkeby`, `kovan` or custom, in which case, it will use the specified `networkId`
- **networkId**: Used when `networkType` is set as `custom`. [List of known network ids](https://github.com/ethereumbook/ethereumbook/blob/3e8cf74eb935d4be495f4306b73de027af95fd97/contrib/devp2p-protocol.asciidoc#known-current-network-ids)
- **isDev**: Whether or not to use the development mode of the Node
  - This is a special mode where the node uses a development account as defaultAccount. This account is already funded and transactions are faster
  - It is recommended to start by using `isDev: true` for you project, as it is faster and safer
- **nodiscover**: Disables the peer discovery mechanism when set to `true`
- **maxpeers**:  Maximum number of network peers
- **proxy**: Whether or not Embark should use a proxy to add functionnalities
  - This proxy is used by Embark to see the different transactions that go through, for example, and shows them to you
- **targetGasLimit**: Artificial target gas floor for the blocks to mine

## For a private network

A private network is really similar to using the development mode of a client.

The biggest differences is that it doesn't come with a default pre-funded account and it will not use POA (proof of authorithy), meaning that blocks will need to be mined.

Fear not however, Embark has settings to limit the mining to a minimum so that everything can run smoothly while testing in a more realistic environment before going to a test network.

<pre><code class="javascript">privatenet: {
  networkType: "custom",
  networkId: 1337,
  isDev: false,
  datadir: ".embark/privatenet/datadir",
  mineWhenNeeded: true, 
  genesisBlock: "config/privatenet/genesis.json",
  nodiscover: true,
  maxpeers: 0,
  proxy: true,
  accounts: [
    {
      nodeAccounts: true,
      password: "config/privatenet/password"
    }
  ]
}
</code></pre>

Please note, you can always use the parameters we saw in the previous section to override the `default` parameters.

### Parameter descriptions

- **isDev**: You need to set `isDev` to false to use enable any network that isn't the development one
- **datadir**: Behaves the same way as stated above, but it is recommended to use a different for different networks
- **mineWhenNeeded**: Whether to always mine (`false`) or only mine when there is a transaction (`true`)
  - It is recommended to set `mineWhenNeeded` to `true` as otherwise, you CPU will get massively used
- **genesisBlock**: The genesis file to use to create the network
  - This file is used when creating the network. It tell the client the parameters to initiate the node with. You can read more on [genesis blocks here](https://arvanaghi.com/blog/explaining-the-genesis-block-in-ethereum/)
- **accounts**: Array of accounts to connect to
  - We will explain below in more details how to use setup the accounts
  - In this case, we need 1 node account with the following password file
  

## For a test network

Test networks are networks that are public. Knowing that fact, if you want to connect to a node that you control, you will first need to synchronize it. Note that this can take hours, as you need to download the blocks that you are missing to be synchronized with the other peers.

The big advantage of using a local synced node is that you have control over it and it preserves your privacy, as your not using a third party node.

However, like specified, it takes a lot of time to synchronize a node and also requires a lot or computer resources, so keep it in mind if you want to go that route.

<pre><code class="javascript">testnet: {
  networkType: "testnet",
  syncMode: "light",
  accounts: [
    {
      nodeAccounts: true,
      password: "config/testnet/password"
    }
  ]
}
</code></pre>

Here are the necessary parameters. Again, you can add more to override as you see fit.

### Parameter descriptions

- **networkType**: Again, used to specify the network
  - `testnet` here represents Ropsten. You can change the network by using a `networkId` by changing `networkType` to `custom`
- **syncMode**: Blockhain sync mode
  - `light`: Light clients synchronize a bare minimum of data and fetch necessary data on-demand from the network. Much lower in storage, potentially higher in bandwidth
  - `fast`: Faster, but higher store
  - `full`: Normal sync
- **accounts**: Array of accounts to connect to
  - We will explain below in more details how to use setup the accounts
  - In this case, we need 1 node account with the following password file
 
## For the mainnet

Finally, the main network, AKA mainnet.

It may come as no surprise, but to sync to the mainnet, the step and configurations are actually the same as for a test network. So just take a peak above.

The only major difference is that the `networkType` needs to be `custom` with the `networkId` set to `1`.

## Account configurations

As you might have seen in a few sections above, there was an `accounts` parameter.

This parameter let's us customize what the `accounts` will be for our deployment, as well as the accounts that will be clreated and unlocked by our blockchain client.

Here are all the options for the accounts:

<pre><code class="javascript">accounts: [
  {
    nodeAccounts: true,
    numAddresses: "1",
    password: "config/development/devpassword"
  },
  {
    privateKey: "your_private_key"
  },
  {
    privateKeyFile: "path/to/file",
    password: "passwordForTheKeystore"
  },
  {
    mnemonic: "12 word mnemonic",
    addressIndex: "0",
    numAddresses: "1",
    hdpath: "m/44'/60'/0'/0/"
  }
]
</code></pre>

The `accounts` configuration is an array of objects, where each object represents one or more account.

Embark offers you multiple ways to include you account. You can use the one you prefer and ignore the others or mix and match.

{% note warn Using production keys %}
Be careful when using production keys and mnemonics (ie the account where you have real money).

We recommend using environment variables for plain text values like `provateKey` and `mnemonic` and to put the files for `privateKeyFile` and key stores either out of your working directory or ignore by versionning (eg: add the file in gitignore)
{% endnote %}

### Parameter descriptions

- 
