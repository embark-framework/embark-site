title: Usage in Javascript
---

Embark includes in your dapp the EmbarkJS library. This library abstracts different functionality so you can easily & quickly build powerful dapps that leverage different decentralized technologies.
Embark will automatically initialize EmbarkJS with the configurations set for your particular environment.

### Provider

As of [EIP1102](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1102.md), decentralized applications MUST request account access. Embark offers several options on how to implement this.

An Embark application's Smart Contract configuration file (typically located in `config/contracts.js`) comes with a `dappAutoEnable` property which controls whether or not EmbarkJS should automatically try to request account access:
<pre><code class="javascript">
...
  // Automatically call `ethereum.enable` if true.
  // If false, the following code must run before sending any transaction: `await EmbarkJS.enableEthereum();`
  // Default value is true.
  // dappAutoEnable: true,
...
</code></pre>

By default, the value of `dappAutoEnable` is true which means that Embark will call `ethereum.enable` for you to request account access when the first page of the dapp is loaded.

If you want more control, you can set `dappAutoEnable` to false.
Then, if you want to request account access, you can use the following code: 

<pre><code class="javascript">
...
  try {
    const accounts = await EmbarkJS.enableEthereum();
    // access granted
  } catch() {
    // access not granted
  }
...
</code></pre>

This will request account access and if the user grants access to his accounts, you will be able to make transaction calls.


### Components

* [EmbarkJS.Contract](contracts_javascript.html) - To interact with smart contracts. Typically Embark automatically initializes all your deployed contracts with this. uses web3.js 1.0
* [EmbarkJS.Storage](storage_javascript.html) - To interact with the configured decentralized storage. Includes bindings to save & retrieve data, upload & download files, etc..
* [EmbarkJS.Communication](messages_javascript.html) - To interact with the configured decentralized messages system. Includes bindings to listen to topics and send messages.
* [EmbarkJS.Names](naming_javascript.html) - To interact with the configured decentralized naming system such as ENS. Includes bindings to look up the address of a domain name as well as retrieve a domain name given an address.

### Utilities

EmbarkJS also includes a `onReady` function. This is very useful to ensure that your Dapp only starts interacting with contracts when the proper connection to web3 has been made and ready to use.

<pre><code class="javascript">import EmbarkJS from 'Embark/EmbarkJS';
import SimpleStorage from 'Embark/contracts/SimpleStorage';

EmbarkJS.onReady(function(error) {
  if (error) {
    console.error('Error while connecting to web3', error);
    return;
  }
  // start using contracts
  SimpleStorage.methods.set(100).send();
});
</code></pre>
