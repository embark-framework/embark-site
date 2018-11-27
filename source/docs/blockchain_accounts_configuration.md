title: Accounts Blockchain configuration
---

As you might have seen in a few sections above, there is also an `accounts` parameter.

This parameter let's us customize what the `accounts` will be for our deployment, as well as the accounts that will be created and unlocked by our blockchain client.

{% note info Old parameters %}
In Embark 3.2 and older, there used to be `account` and `simulatorMnemonic`.

`account` is replaced by `nodeAccounts`.

`simulatorMnemonic` is replaced by adding a `mnemonic` account in the `accounts` array. This works both for the simulator and for clients.
{% endnote %}

## Accounts parameters

<pre><code class="javascript">accounts: [
  {
    nodeAccounts: true,
    numAddresses: "1",
    password: "config/development/devpassword"
  },
  {
    privateKey: process.env.MyPrivateKey
  },
  {
    privateKeyFile: "path/to/file",
    password: process.env.MyKeyStorePassword
  },
  {
    mnemonic: process.env.My12WordsMnemonic,
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

We recommend using environment variables for plain text values like `privateKey` and `mnemonic` and to put the files for `privateKeyFile` and key stores either out of your working directory or ignored by versioning (eg: add the file in gitignore)
{% endnote %}

### Parameter descriptions

- **nodeAccounts**: The actual node accounts, that get created and unlocked by the client
  - Needs to be put to `true` to be activated
  - **numAddresses**: Number of addresses you want from the node. Defaults to `1`
  - **password**: Password file where the password to create and unlock the accounts is. Required
- **privateKey**: Private key string
- **privateKeyFile**: Either a file containing comma separated private keys or a keystore (password needed for the latter)
  - **password**: Password string for the keystore
- **mnemonic**: 12 word mnemonic
  - **addressIndex**: Index where to start getting the addresses. Defaults to `0`
  - **numAddresses**: Number of addresses to get. Defaults to `1`
  - **hdpath**: HD derivation path. Defaults to `"m/44'/60'/0'/0/"`
