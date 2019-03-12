title: How to upgrade to Embark 4
summary: "In this guide, we'll show how to upgrade from an Embark 3.x project to Embark 4"
categories:
  - tutorials
---

The release of Embark 4.0 is close at hand and beta.2 is the relase to introduce some real breaking changes. Let's dive right into them.

## Use the pipeline that YOU want

You read correctly! You no longer need to use Embark's pipeline, which, let's not hide it, is pretty slow.

Historically, Embark has come with a special Webpack pipeline because it made your work, as a user, easier. Indeed, it enabled you to use simple "magic" imports, such as `import SimpleStorage from "Embark/contracts/SimpleStorage";`. It also did the connection to Web3 for you.

However, we discovered the hard way that those advantages ended not being worth the price of performance that you pay, when you can't use an optimized pipeline, like create-react-app or Angular CLI.

Therefore, we are announcing that Embark 4 can use **any** frontend development pipeline, letting Embark handle the things that it does best. This means we can use tools such as `create-react-app` or Angular CLI alongside Embark. The Embark 3.x pipeline is still available for use for quick start applications if needed.

So, as you just read, it's not really a breaking change, well  that is, unless you decide you want to convert you Dapp from Embark's pipeline to the one of your choice.

If you don't plan on starting a project with another pipeline or don't plan of converting, you can skip to [the next section](#New-Web3-plugin).

### Converting to another pipeline

The first thing you might want to do is change or add the new `generationDir` property in `embark.json`. This property tells Embark where to generation the various artifacts that you will need to build your Dapp. Most of those artifacts were already generated before, but were inside the `.embark/` folder. 

Since most file pipelines need those files inside the source folder, we're going to put `generationDir` as your selected pipeline's source folder. For example,  create-react-app (CRA) has `src/` as source folder.

Afterwards, we need to convert all "magic" imports to relative imports.

The first one is the EmbarkJS import. The "magic" import is `"Embark/EmbarkJS"`. We need to convert that to the relative path. The `embarkjs.js` script is at the root of  `embarkArtifacts/`, so you need to convert it to something like `"./embarkArtifacts/embarkjs"`.

Second ones are the contracts. They used to look like `"Embark/contract/ContractName"`. They are now located inside `embarkArtifactscontracts/`.

Third one, there used to be `"Embark/web3"`, but we removed it. Don't worry, we are not removing web3 support, far from it. We actually just got rid of that useless import that didn't do much. All you have to do is use the global `web3` object that is avilable everywhere in the Dapp.

Then, you can move your Embark files and configs inside a project created by the pipeline of your choice.

### New project with another pipeline

If you are starting your project from scratch, you have two options.

The easier one is to use our new Embark CRA template (TODO add template URl). It sets up a simple Embark project for you with the all of the files you are used to. The only slight difference is that the config files are in `embarkConfig` to make sure they don't clash with CRA's config. It's already set up for you to start and use. You only need to do `embark run` and in another terminal `yarn start` or `npm run start` to start CRA.

The other solution is to create a project with your chosen pipeline and then (TODO new command or we need to do it in another).

## New Web3 plugin

Starting with Embark 4 beta.2, Embark no longer comes with Web3js by default for your Dapp. Don't run. We did that so that we can now have the possibility of supporting more than just Web3js, but potentially EthersJS and more (even the possibility for you to do it).

Anyway, to continue having Web3js inside your Dapp, you only have to call the following command in the Embark console: `plugin install embarkjs-connector-web3`

As you can see, it's just a plugin. You can install it manually instead by doing:
1. `yarn add embarkjs-connector-web3` or `npm install --save embarkjs-connector-web3`
2. Adding `"embarkjs-connector-web3": {}` to the `plugins` section of `embark.json`

It's as simple as that. This plugin will add the necessary commands and code for your Dapp to connect to the blockchain and register the necessary providers. The only prerequisite is that you import `EmbarkJS` at least once. That file is located at `embarkArtifacts/embarkjs.js` or if you still use Embark's pipeline, you can import it using `import EmbarkJS from "Embark/EmbarkJS";`.

## New Blockchain account configs

In Embark 4 alpha, we added some new blockchain account configurations. They are really similar to the ones you have in the contract configuration. You can find more details in our [Accounts Blockchain configuration guide](https://embark-site-develop.netlify.com/docs/blockchain_accounts_configuration.html).

However, we did introduce some small breaking changes. We removed: 
- `account`: This is completely replaced by the new `accounts` property. It gives you more flexibility. To have exactly the same behavior as before, just use the `nodeAccount` account type
- `simulatorMnemonic`: Removed because it was mostly useless. Ganache CLI has a default mnemonic. Also, you get the same behavior as before with the `mnemonic` account type

## Conclusion

Embark 4 contains way more new features than those listed above. Once we release officially Embark 4, we'll list all of those cool features for you.

In the meantime, you can see that all that goodness doesn't come at too high a price it terms of breaking changes.

Hopefully, you'll have a blast upgrading to Embark 4 and if you ever have an issue, make sure to hit us on [Gitter](https://gitter.im/embark-framework/Lobby).
