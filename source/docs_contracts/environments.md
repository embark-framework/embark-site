title: Environments
---

Developing on Ethereum requires you to #buidl everything locally, then deploy it on various test networks, and only then get to the big show. Setting up connections and deploying contracts easily to all these different environments is a pain. But do not fear, Embark has you covered. We use the concept of `environments`, which means that every config file has entries for each environment so you can control them all sensibly from one place that can be specified in most embark commands.

### Configuration

`default` is a special environment - the values you use here will apply to all environments unless you have set specific values for the environments you want to work in.
Every other config block is then merged with `default`, which means that you can specify the most common options in default and then only override what's really needed on a per environment basis.

Example:

<pre><code class="javascript">module.exports = {
  "default": {
    "gas": "auto",
    "contracts": {
      "Foo": {
        "args": [ 200 ]
      }
    }
  },
  "development": {
    "contracts": {
      "Token": {
        "args": [ 100 ]
      }
    }
  },
  "myenvironment": {
    "contracts": {
      "Token": {
        "address": "0x420be61af1dea86646269f9f892a1b2a57fe24f2"
      }
    }
  }
}
</code></pre>

If the `development` environment is specified, then the `development` config will merge with `default` and the config used will be:

<pre><code class="json">{
  "gas": "auto",
  "contracts": {
    "Foo": {
      "args": [ 200 ]
    },
    "Token": {
      "args": [ 100 ]
    }
  }
}
</code></pre>


If the `myenvironment` environment is specified, then the `myenvironment` config will merge with `default` and the config used will be:

<pre><code class="json">{
  "gas": "auto",
  "contracts": {
    "Foo": {
      "args": [ 200 ]
    },
    "Token": {
      "address": "0x420be61af1dea86646269f9f892a1b2a57fe24f2"
    }
  }
}
</code></pre>

### Specifying an environment

<pre><code class="shell">$ embark &lt;cmd_name&gt; &lt;environment&gt;
</code></pre>

For example, if you want to specify the 'testnet' environment in the `embark run` command you would do:

<pre><code class="shell">$ embark run testnet
</code></pre>

If no environment is specified, Embark assumes `development` to be the intended environment, so 

<pre><code class="shell">$ embark run
</code></pre>

is the same as

<pre><code class="shell">$ embark run development
</code></pre>


