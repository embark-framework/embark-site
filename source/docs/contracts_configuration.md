title: Configuring Smart Contracts
---

As many decentralized applications are powered by Smart Contracts, configuring and deploying them should be easy. That's why Embark offers a declarative approach to define what Smart Contracts we're interested in to deploy, what their dependencies are, as well as what they should be initialized with once instantiated. This guide will explore the different configuration options that help making deploying Smart Contracts a breeze.

## Basic Smart Contract Configuration

Unless specified differently in our application's `embark.json`, Smart Contracts are configured either in the `config/contracts.js` file, or, if we're dealing with a [Smart Contract only app](create_project.html#Creating-%E2%80%9Ccontracts-only%E2%80%9D-apps), the `./contracts.js` file in the root of our project.

A Smart Contract configuration is placed in an environment's `contracts` property, with the name of the Smart Contract being the identifier. The following code creates a configuration for the `SimpleStorage` contract in the `development` environment:

<pre><code class="javascript">module.exports = {
  ...
  development: {
    ...
    contracts: {
      SimpleStorage: {
        ...
      }
    }
  }
  ...
}
</code></pre>

Smart Contracts can be configured differently per environment just by adding a dedicated configuration to the corresponding environment. Head over to our [guide on environments](environments.html) to learn more about this.

### Configuring constructor parameters

Often, Smart Contracts need to be initialized with certain values right after they have been deployed. We can configure a Smart Contract's constructor parameters using the `args` property. `args` is either a list of values, which will be applied to the Smart Contract's constructor parameters in the same order they are defined, or it can be an object specifying the parameters using named keys.

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    args: [100]
  }
}
...
</code></pre>

The following configuration configures the `SimpleStorage`'s `initialValue` parameter, assuming that that one exists. Notice that by using this syntax, the order of constructor parameter values doesn't matter anymore:

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    args: { initialValue: 100 }
  }
}
...
</code></pre>

### Configuring gas and gas price

Both, `gas` and `gasPrice` can be configured for each Smart Contract. If we don't want to configure that for every single contract, we can also specify `gas: auto` in the environment, like this:

<pre><code class="javascript">...
development: {
  gas: 'auto',
  contracts: {
    SimpleStorage: {
      args: [100],
      gas: 800000,
      gasPrice: 5
    }
  }
}
...
</code></pre>

Another cool feature of Embark is that it supports human readable ether units, to improve the developer experience.

{% note info Human readable ether units %}

Embark supports **human readable ether units** in places where ether unit values are required. [Read here](#Human-readable-Ether-units) for more information.
{% endnote %}

## Configuring Smart Contract Dependencies

When building more complex applications, it's very common that a Smart Contract depends on another one. Embark makes it very easy to not only ensure dependency Smart Contracts are deployed before the Smart Contract in question deploys, but also accessing their deployed addresses. 

All we have to do is specifying the name of the Smart Contract we're interested in, prefixed with a "$". Embark will then take care of figuring out in which order our Smart Contracts need to be deployed, as well as replacing all `$CONTRACT_NAME`'s with their corresponding addresses. Assuming `SimpleStorage` depends on `OtherContract`, this can be easily configured like this:

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    args: [100, '$OtherContract']
  },
  OtherContract: {...}
}
...
</code></pre>

## Disabling deployment

Sometimes we want to configure different behaviour for certain contracts within different [environments](environments.html). One of those cases could be that we don't actually want to deploy `SimpleStorage` in the production environment as we might expect some other storage Smart Contract to already be somewhere out there.

We can prevent Embark from deploying any of our Smart Contracts by using the `deploy` configuration and setting it to `false` like this:

<pre><code class="javascript">...
development: 
  contracts: {
    SimpleStorage: {
      args: [100]
    }
  }
},
production: {
  contracts: {
    SimpleStorage: {
      deploy: false
    }
  }
}
...
</code></pre>


## Deploying multiple instances

In cases where we want to create multiple instances of the same Smart Contract but with, for example, different initialization values per instance, we can use the `instanceOf` property and refer to the original Smart Contract that should be deployed multiple times.

This can then be combined with [disabling the deployment](#Disabling-deployment) of the original Smart Contract like this:

<pre><code class="javascript">...
contracts: {
  Currency: {
    deploy: false,
  },
  Usd: {
    instanceOf: 'Currency',
    args: [200]
  },
  MyCoin: {
    instanceOf: 'Currency',
    args: [300]
  }
}
...</code></pre>

In the example above, we deploy `Usd` and `MyCoin` as instances of `Currency`. Notice that `Currency` itself isn't going to be deployed but merely functions as a "recipe" to create other instances of it.

## Referencing already deployed Smart Contracts

Embark not only integrates with the Smart Contracts that we create and own, but also with Smart Contracts that are already deployed and potentially owned by third-parties. If we wish to reference such a Smart Contract instance, all we have to do is specify the `address` of the instance in question.

The following example configures `UserStorage` to be a Smart Contract instance that's already deployed:

<pre><code class="javascript">...
contracts: {
  UserStorage: {
    address: '0x123456'
  }
}
...
</code></pre>

## Configuring source files

By default Embark will look for Smart Contracts inside the folder that's configured in the application's [embark.json](configuration.html#contracts), the default being the `contracts` folder. However, if we want to change the location to look for a single Smart Contract's source, or need to compile a third-party Smart Contract to get hold of its ABI, we can do so by using the `file` property.

`file` specifies a full path to a file that contains the source code for the Smart Contract in question.

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    file: './some_folder/simple_storage.sol',
    args: [100]
  }
}
...
</code></pre>

If Embark doesn't find the file in the specified path, it'll expect it to be a path inside installed `node_modules` dependencies. The following example configures a source file path that points to a third-party Smart Contract that is installed as a dependency:

<pre><code class="javascript">...
contracts: {
  ERC20: {
    file: 'openzeppelin-solidity/contracts/token/ERC20/ERC20.sol'
  }
}
...
</code></pre>

Embark even supports reading the source from `https`, `git`, `ipfs` and `bzz` URIs, enabling us to compile Solidity Smart Contracts that aren't even located in our local machine.

<pre><code class="javascript">...
contracts: {
  ERC725: {
    file: 'git://github.com/status/contracts/contracts/identity/ERC725.sol#develop'
  },
  ERC725: {
    file: 'github.com/status/contracts/contracts/identity/ERC725.sol'
  },
  Ownable: {
    file: 'https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/ownership/Ownable.sol'
  }
}
...
</code></pre>

## Providing ABIs

In order to use Smart Contract instances created by web3 either in [deployment hooks](Deployment-hooks) or in [Embark's JavaScript client](contracts_javascript.html), Embark needs to get hold of the Smart Contracts' ABIs and pass those on to web3.

This is not a problem when dealing with Smart Contracts that we own, or at least have [access to their sources](#Configuring-source-files) so we Embark can compile them accordingly. However, if we don't have either the source, nor do we want to create a Solidity interface ourselves for Embark to compile, we can provide an already defined ABI for a dedicated Smart Contract using the `abiDefinition` property, so Embark can make use of that.

The following example configures `SimpleStorage` to be already deployed somewhere, but we'd still like to use the web3 instance in our `afterDeploy` hook.

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    address: '0x0bFb07f9144729EEF54A9057Af0Fcf87aC7Cbba9',
    abiDefinition: [...]
  }
},
afterDeploy: async (deps) => {
  const value = await deps.contracts.SimpleStorage.methods.get().call();
  console.log(value);
}
...
</code></pre>

`afterDeploy` and other deployment hooks are covered in [Deployment Hooks](#Deployment-hooks).

## Providing Artifacts

Similar to Provider ABIs, providing an Embark artifact let's you configure your contract using an already generated artifact.

That way, you don't need to have the contract on disk or even deploy it, if the address is specified in it.

Here is how you can do it:

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    artifact: './path/to/SimpleStorage.json'
  }
}
...
</code></pre>

## Deployment tracking

Embark's Smart Contract deployment mechanism prevents the deployment of Smart Contracts that have already been deployed. This turns out to be a powerful feature as you don't have to worry about keeping track of it. If we prefer to have full control over the deployment process and don't want Embark to keep track of individual Smart Contracts deployments, we use the `track` configuration and set it `false`.

The following example ensure `ERC20` won't be tracked and therefore redeployed in every deployment cycle.

<pre><code class="javascript">...
contracts: {
  ERC20: {
    track: false
  }
}
...
</code></pre>

## Deployment hooks

Sometimes we want to execute certain logic when Smart Contracts are being deployed or after all of them have been deployed. In other cases, we'd even like to control whether a Smart Contract should be deployed in the first place. For those scenarios, Embark lets us define the deployment hooks `deployIf`, `onDeploy` and `afterDeploy`.

Deployment hooks have access to a `dependencies` object that comes with instances of all Smart Contracts that are defined as dependency of the hooks using the `deps` property of the Smart Contract in question, and the Smart Contract itself. In addition to all relevant Smart Contract instances, this object also exposes the current `web3` instance as shown in the examples below.

### Conditional Deployment with `deployIf`

We can specify a condition that decides whether a contract should be deployed by using the `deployIf` hook. `deployIf` is a function that either returns a promise or is created using `async/await` syntax and has to resolve to a boolean value. If the resolve value is `true`, the Smart Contract in question will be deployed. If it's `false`, Embark will skip deploying the Smart Contract in question.

<pre><code class="javascript">...
contracts: {
  ERC20: {
    deployIf: async (dependencies) => {
      return await dependencies.contracts.Manager.methods.isUpdateApproved().call();
    },
    deps: ['Manager']
  },
  Manager: {...}
}
...
</code></pre>

Notice how `dependencies.contracts` gives access to the `Manager` contract instance. This however, is only possible because `Manager` has been defined as dependency of `ERC20` using the `deps` property. If we're using a Node version that doesn't support async/await, the same can be achieved using promises like this (web3 APIs already return promises):

<pre><code class="javascript">...
ERC20: {
  deployIf: (dependencies) => {
    return dependencies.contracts.Manager.methods.isUpdateApproved().call();
  },
  deps: ['Manager']
},
...
</code></pre>

### `onDeploy` hook

We can specify the `onDeploy` hook to execute code, right after a contract has been deployed. Just like `deployIf` and `afterDeploy`, `onDeploy` is a function that has access to the Smart Contract's dependencies defined in its `deps` property. The following example executes `SimpleStorage`'s `set()` method, once deployed.

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    args: [100],
    onDeploy: async (dependencies) => {
      await dependencies.contracts.SimpleStorage.methods.set(150).send();
    }
  }
}
...
</code></pre>

As mentioned above, every deployment hook works with plain promises as well:

<pre><code class="javascript">...
SimpleStorage: {
  args: [100],
  onDeploy: (dependencies) => {
    return dependencies.contracts.SimpleStorage.methods.set(150).send();
  }
}
...
</code></pre>

### `afterDeploy` hook

If we want to execute code once all of our Smart Contracts have been deployed, Embark has got us covered with the `afterDeploy` hook. The same rules apply here. `afterDeploy` has access to all deployed contract instances through the `dependencies` object.

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    args: [100]
  },
},
afterDeploy: (dependencies) => {
  dependencies.contracts.SimpleStorage.methods.set(150).send();
}
...
</code></pre>

{% note info A note on deployment hook string syntax %}
In older versions of Embark, deployment hooks have been defined as an array of strings. This is due historical reasons where configuration files used to be JSON files that don't support functions.

The examples above can be therefore written as:

<pre><code class="javascript">afterDeploy: ['SimpleStorage.methods.set(150).send()']
onDeploy: ['SimpleStorage.methods.set(150).send()']
deployIf: 'await Manager.methods.isUpdateApproved()'
</code></pre>


This string syntax is still supported but will be deprecated and likely be removed in future versions of Embark.
{% endnote %}

## Human readable Ether units

Embark supports human readable ether units in different places where Ether values can be configured. A human readable ether unit is the combination of any number value and any valid ether unit, such as `wei`, `kwei`, `Kwei`, `shannon`, `finney`, ... etc.

Let's take the simple Smart Contract configuration from the [configuring gas and gas price](#Configuring-gas-and-gas-price) section:

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    args: [100],
    gas: 800000,
    gasPrice: 5
  }
}
...
</code></pre>

This can as well be written as:

<pre><code class="javascript">...
contracts: {
  SimpleStorage: {
    args: [100],
    gas: '800 Kwei',
    gasPrice: 5
  }
}
...
</code></pre>

Embark will take care of converting those units to their dedicated Wei values.
