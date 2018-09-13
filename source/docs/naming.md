title: Naming (ENS)
---

### Setup

By default Embark will automatically initialize EmbarkJS with the provider configured at `config/namesystem.js`.


### Configuration basics

Embark checks your configuration in `config/namesystem.js`. None of them are necessary to run Embark, you need only enable those when you want to use the name system.

When using ENS (`"ens"`) as your provider, you can set the `register` section to pre-register sub-domains. Feature only available in development environment.

```Javascript
module.exports = {
  default: {
    enabled: true,
    available_providers: ["ens", "ipns"],
    provider: "ens",
    // The register section is only used in development. It allows you to pre-register domains
    register: {
      rootDomain: "embark.eth", // The root domain to which you can attach the subdomains. The address will be pointing to the defaultAccount
      subdomains: {
        // List of subdomains.
        // The key is the name (eg: status -> status.embark.eth)
        // The value is the address to where the subdomain points
        'status': '0x1a2f3b98e434c02363f3dac3174af93c1d690914'
      }
    }
  }
};
```

### Resolve the address for an ENS domain
Also works for sub-domains

```Javascript
EmbarkJS.Names.resolve('domain.eth', (err, result) => {
  if (err) {
    console.error('ENS resolve error', err);
  }
  console.log('ENS address', result)
});
```

### Reverse resolve an ENS domain
Also known as lookup. Retrieves the domain name (or sub-domain name) from the address

```Javascript
EmbarkJS.Names.lookup('0x1a2f3b98e434c02363f3dac3174af93c1d690914', (err, result) => {
  if (err) {
    console.error('ENS lookup error', err);
  }
  console.log('ENS domain', result)
});
```

### Register a sub-domain
This enables you to register some others sub-domains.
This is mostly for demo purposes as it is only available in development.

```Javascript
 EmbarkJS.Names.registerSubDomain('newsubdomain', '0x4a17f35f0a9927fb4141aa91cbbc72c1b31598de', (err, transaction) => {
  if (err) {
    console.error('ENS register error', err);
  }
  console.log(`Successfully registered with ${transaction.gasUsed} gas`);
});
```




