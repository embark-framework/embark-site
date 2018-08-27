title: Usage in Javascript
---

Embark includes in your dapp the EmbarkJS library. This library abstracts different functionality so you can easily & quickly build powerful dapps that leverage different decentralized technologies.
Embark will automatically initialize EmbarkJS with the configurations set for your particular environment.

### Components

* [EmbarkJS.Contract](contracts_javascript.html) - To interact with smart contracts. Typically Embark automatically initializes all your deployed contracts with this. uses web3.js 1.0
* [EmbarkJS.Storage](storage_javascript.html) - To interact with the configured decentralized storage. Includes bindings to save & retrieve data, upload & download files, etc..
* [EmbarkJS.Communication](messages_javascript.html) - To interact with the configured decentralized messages system. Includes bindings to listen to topics and send messages.
* [EmbarkJS.Names](naming_javascript.html) - To interact with the configured decentralized naming system such as ENS. Includes bindings to look up the address of a domain name as well as retrieve a domain name given an address.

### Utilities

EmbarkJS also includes a `onReady` function, this is very useful to ensure that your dapp only starts interacting with contracts when the proper connection to web3 has been made and ready to use.

<pre><code class="javascript">import EmbarkJS from 'Embark/EmbarkJS';
import SimpleStorage from 'Embark/contracts/SimpleStorage';

EmbarkJS.onReady(function() {
  // start using contracts
  SimpleStorage.methods.set(100).send();
})
</code></pre>

