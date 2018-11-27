title: Testnet Blockchain configuration
---

Test networks are networks that are public. Knowing that fact, if you want to connect to a node that you control, you will first need to synchronize it. Note that this can take hours, as you need to download the blocks that you are missing from the other peers.

The big advantage of using a local synced node is that you have control over it and it preserves your privacy, as you are not using a third party node.

However, like specified, it takes a lot of time to synchronize a node and also requires a lot of computer resources, so keep it in mind if you want to go down that route.

## Testnet parameters

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
