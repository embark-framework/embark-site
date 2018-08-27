title: Naming System (ENS) Usage in Javacript
---

### Resolving a Domain to an address

<pre><code class="javascript">EmbarkJS.Names.resolve("ethereum.eth").then(function(address) {
  console.log("the address for ethereum.eth is: " + address);
})
</code></pre>

### Resolving an address given a Domain

<pre><code class="javascript">EmbarkJS.Names.lookup("0xfb6916095ca1df60bb79ce92ce3ea74c37c5d359").then(function(name) {
  console.log("the domain is: " + name);
})
</code></pre>

