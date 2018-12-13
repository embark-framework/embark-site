title: Solidity Imports
---

### Importing files in contracts

If using Solidity it's also possible to directly import contract files inside the dapp from folders that are not explicity defined in the `contracts` propery of `embark.json`.

<pre><code class="solidity">import "another_folder/another_test.sol";</code></pre>

You can also import a contract file from an npm package:

<pre><code class="solidity">import "openzeppelin-solidity/contracts/ownership/Ownable.sol";</code></pre>

You can even use files directly from Git, Github or directly from HTTP(S):

<pre><code class="solidity">import "git://github.com/status/contracts/contracts/identity/ERC725.sol#develop";
import "github.com/status/contracts/contracts/identity/ERC725.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/ownership/Ownable.sol";
</code></pre>

