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

