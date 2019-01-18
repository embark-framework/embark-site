title: Blockchain configuration
---

When in development phase, to interact with the blockchain, it is necessary to use a local Ethereum node, either using a simulator or a client like Geth or Parity.

In this guide we'll explore how to configure the blockchain node we want Embark to connect to.

To set this blockchain node, Embark looks at `blockchain.js`, which by default is at `config/blockchain.js`.

Embark offers a lot of configuration options and most of them already come with a decent default so we can start right away.

## Common Parameters

Here are the common parameters:

<pre><code class="javascript">module.exports = {
  default: {
    enabled: true,
    rpcHost: "localhost",
    rpcPort: 8545,
    rpcCorsDomain: {
      auto: true,
      additionalCors: ['localhost:9999']
    },
    wsRPC: true,
    wsOrigins: {
      auto: true,
      additionalCors: []
    },
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

Similar to [configuring Smart Contracts](/docs/contracts_configuration.html), this config contains environments that help configuring certain parameters differently depending of the environment. You can read more about [environments here](https://embark.status.im/docs/environments.html).

### Parameter descriptions

- **enabled**: Whether or not to spawn an Ethereum node
- **rpcHost**: Host the RPC server listens to
- **rpcPort**: Port the RPC server listens to
- **rpcCorsDomain**: The CORS domains the node accepts
  - **auto**: When set to true, Embark checks your other configurations to set the CORS domains. This only adds the required domains.
  - **additionalCors**: Manual list of CORS domains to accept. If `auto` is set to `true`, any URLs specified here will be applied *in addition to* those automatically added with `auto`.
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


### Using Parity and Metamask
{% note tip %}

Parity has very strict CORS policies.
In order to use it with Metamask (or any other browser extension), you need to add the extension's URL in the CORS.

You can do so by opening Metamask in its own tab. Then, copy the URL.
It will look something like `chrome-extension://nkbihfbeogaeaoehlefnkodbefgpgknn`.

Afterwards, in your blockchain config, add it to `additionalCors` of `rpcCorsDomain` and `wsOrigins`.
{% endnote %}

## Privatenet configuration

A private network is really similar to using the development mode of a client.

The biggest differences is that it does not come with a default pre-funded account and it will not use POA (proof of authority), meaning that blocks will need to be mined.

Fear not, Embark has settings to limit the mining to a minimum so that everything can run smoothly while testing in a more realistic environment before going to a test network.

### Privatenet parameters

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

Please note, you can always use the parameters we saw in the [Common parameters section](#Common-Parameters) to override the `default` parameters.

### Parameter descriptions

- **isDev**: You need to set `isDev` to false to use enable any network that isn't the development one
- **datadir**: Behaves the same way as stated above, but it is recommended to use a different for different networks
- **mineWhenNeeded**: Whether to always mine (`false`) or only mine when there is a transaction (`true`)
  - It is recommended to set `mineWhenNeeded` to `true` as otherwise, you CPU will get massively used
- **genesisBlock**: The genesis file to use to create the network
  - This file is used when creating the network. It tell the client the parameters to initiate the node with. You can read more on [genesis blocks here](https://arvanaghi.com/blog/explaining-the-genesis-block-in-ethereum/)
- **accounts**: Array of accounts to connect to
  - Go to the [Accounts configuration](/docs/blockchain_accounts_configuration.html) page to learn more on accounts
  - In this case, we need 1 node account with the following password file


## Testnet configuration

Test networks are networks that are public. Knowing that fact, if you want to connect to a node that you control, you will first need to synchronize it. Note that this can take hours, as you need to download the blocks that you are missing from the other peers.

The big advantage of using a local synced node is that you have control over it and it preserves your privacy, as you are not using a third party node.

However, like specified, it takes a lot of time to synchronize a node and also requires a lot of computer resources, so keep it in mind if you want to go down that route.

### Testnet parameters

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
  - Go to the [Accounts configuration](/docs/blockchain_accounts_configuration.html) page to learn more on accounts
  - In this case, we need 1 node account with the following password file


## Mainnet configuration

Finally, the main network, AKA mainnet.

It may come as no surprise, but to sync to the mainnet, the step and configurations are actually the same as for a [test network](#Testnet-configuration).

The only major difference is that the `networkType` needs to be `custom` with the `networkId` set to `1`.

<pre><code class="javascript">mainnet: {
  networkType: "custom",
  networkId: 1,
  syncMode: "light",
  accounts: [
    {
      nodeAccounts: true,
      password: "config/mainnet/password"
    }
  ]
}
</code></pre>

