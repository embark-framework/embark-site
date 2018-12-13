title: Naming Configuration
---

### Setup

By default Embark will automatically initialize EmbarkJS with the provider configured at `config/namesystem.js`.


### Configuration basics

Embark checks your configuration in `config/namesystem.js`. None of them are necessary to run Embark, you need only enable those when you want to use the name system.

When using ENS (`"ens"`) as your provider, you can set the `register` section to pre-register sub-domains. Feature only available in development environment.

<pre><code class="javascript">
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
</code></pre>
