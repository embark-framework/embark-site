title: Naming System (ENS) Usage in Javacript
---

### Resolve the address for an ENS domain
Also works for sub-domains

<pre><code class="javascript">
EmbarkJS.Names.resolve('domain.eth', (err, result) => {
  if (err) {
    console.error('ENS resolve error', err);
  }
  console.log('ENS address', result)
});
</code></pre>

### Reverse resolve an ENS domain
Also known as lookup. Retrieves the domain name (or sub-domain name) from the address

<pre><code class="javascript">
EmbarkJS.Names.lookup('0x1a2f3b98e434c02363f3dac3174af93c1d690914', (err, result) => {
  if (err) {
    console.error('ENS lookup error', err);
  }
  console.log('ENS domain', result)
});
</code></pre>

### Register a sub-domain
This enables you to register some others sub-domains.
This is mostly for demo purposes as it is only available in development.

<pre><code class="javascript">
 EmbarkJS.Names.registerSubDomain('newsubdomain', '0x4a17f35f0a9927fb4141aa91cbbc72c1b31598de', (err, transaction) => {
  if (err) {
    console.error('ENS register error', err);
  }
  console.log(`Successfully registered with ${transaction.gasUsed} gas`);
});
</code></pre>
