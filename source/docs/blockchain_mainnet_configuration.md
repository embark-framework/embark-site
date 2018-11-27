title: Mainnet Blockchain configuration
---

Finally, the main network, AKA mainnet.

It may come as no surprise, but to sync to the mainnet, the step and configurations are actually the same as for a [test network](/docs/blockchain_testnet_configuration.html).

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
