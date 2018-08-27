title: Contracts Usage in Javascript
---

### Interacting with contracts in Javascript

Embark will automatically take care of deployment for you and set all needed JS bindings. For example, the contract below:

<pre><code class="solidity">// app/contracts/simple_storage.sol
contract SimpleStorage {
  uint public storedData;

  function SimpleStorage(uint initialValue) {
    storedData = initialValue;
  }

  function set(uint x) {
    storedData = x;
  }
  function get() constant returns (uint retVal) {
    return storedData;
  }
}
</code></pre>

Will automatically be available in Javascript as:

<pre><code class="javascript">// app/js/index.js
import SimpleStorage from 'Embark/contracts/SimpleStorage';

SimpleStorage.methods.set(100).send();
SimpleStorage.methods.get().call().then(function(value) { console.log(value) });
SimpleStorage.methods.storedData().call().then(function(value) { console.log(value) });
</code></pre>

The syntax used is <a href="http://web3js.readthedocs.io/en/1.0/" target="_blank">web3.js 1.0</a>
