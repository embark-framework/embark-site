title: Privatenet Blockchain configuration
---

A private network is really similar to using the development mode of a client.

The biggest differences is that it does not come with a default pre-funded account and it will not use POA (proof of authority), meaning that blocks will need to be mined.

Fear not, Embark has settings to limit the mining to a minimum so that everything can run smoothly while testing in a more realistic environment before going to a test network.

## Testnet parameters

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

Please note, you can always use the parameters we saw in the [previous section](/docs/blockchain_basic_configuration.html) to override the `default` parameters.

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
