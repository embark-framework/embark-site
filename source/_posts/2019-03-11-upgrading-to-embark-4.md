title: How to upgrade to Embark 4
summary: "In this guide, we'll learn how to upgrade a Dapp created with Embark 3.x to Embark 4"
categories:
  - tutorials
---

The release of Embark 4.0 is close at hand and the release candidate, `beta.2` will introduce some breaking changes. Let's see what it takes to update an Embark 3.x Dapp to Embark 4.

## Use the pipeline that YOU want

That's right! The use of Embark's builtin pipeline in no longer required.

Historically, Embark 3.x came with a special Webpack pipeline because it automated development tasks, such as enabling the use of "magic" imports (ie `import SimpleStorage from "Embark/contracts/SimpleStorage";` or `import EmbarkJS from Embark/EmbarkJS`), and establishing a Web3 connection for the Dapp.

However, we discovered the hard way that those advantages were not worth the hit in development efficiency, when compared to using an optimized pipeline, such as `create-react-app` or Angular CLI, as on every save, Embark would regenerate a lot of the Dapp-side code and then Webpack the entire Dapp, often taking quite some time.

Therefore, we are announcing that Embark 4 can use **any** frontend development pipeline, letting Embark handle the things that it does best. This means we can use tools such as `create-react-app` or Angular CLI alongside Embark. The Embark 3.x pipeline is still available for use for quick start applications if needed.

To migrate an existing Embark 3.x Dapp over to use Embark 4 with a third party pipeline, there are few small changes to your Dapp that are needed.

NOTE: If you are not interested in using a third party pipeline, you can skip to the next section to [see the rest of the breaking changes needed to migrate a Dapp to Embark 4](#New-Web3-plugin).

### Converting to another pipeline
Converting to a third party pipeline is easy. This can be done with three simple improvements that Embark 4 has made available for us.
#### Artifact generation directory
NOTE: If you are planning on using Embark's built-in Webpack pipeline (and not use a third party pipeline), please [skip down to the remainder of the Embark 4 breaking changes](#New-Web3-plugin).

Embark 4 now generates contract artifacts for all of the contracts in your Dapp. These artifacts enable importing the Dapp's contracts in to the Dapp's javascript. Most of these artifacts were already generated before, but lived inside the `.embark/` folder. Since most modern frontend build systems require source files to live inside of a very specific source folder, we have given developers the opportunity to specify the destination folder for these artifacts, allowing the frontend build tool to pack them in to the build files.

The first thing we need to do is add a new `generationDir` property in the root of `embark.json`. This property tells Embark where to place the generated artifacts in the Dapp's filesystem. For example, `create-react-app` (CRA) has `src/` as source folder and the artifacts must be placed in that folder, so we would add in `embark.json`:


#### "Magic" imports
Afterwards, we need to convert all "magic" imports in our Dapp's code to relative imports.

The first one is the EmbarkJS import. The "magic" import is `"Embark/EmbarkJS"`. Anywhere we have `"Embark/EmbarkJS"` in our Dapp's code, we need to convert that to the relative path. Because we are trying to get the `EmbarkJS` library, and the `embarkjs.js` script is located in the root of  `embarkArtifacts/`, we need to replace 

```javascript
import EmbarkJS from "Embark/EmbarkJS"
```
with
```javascript
import EmbarkJS from "./embarkArtifacts/embarkjs"
```
NOTE: The relative path is dependent upon the generationDir setting specified in embark.json (see the "Artifact generation directory" section above](#Artifact generation directory).

Secondly, we need to update the "magic" contract imports. These will need to change from 

```javascript
import ContractName from "Embark/contract/ContractName";
```
to
```javascript
import ContractName from "./embarkArtifacts/contracts/ContractName";
```

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
- `account`: This is completely replaced by the new `accounts` property (notice the `s` at the end of `accounts`). It gives the developer more flexibility. To have exactly the same behavior as before, just use the `nodeAccounts` account type as [described in the docs](https://embark.status.im/docs/blockchain_accounts_configuration.md#parameter-descriptions)
- `simulatorMnemonic`: Removed in favor of Ganache's default mnemonic. If this functionality is still needed, please specify the desired mnemonic in the [blockchain config's `mnemonic` account type](https://embark.status.im/docs/blockchain_accounts_configuration.md#parameter-descriptions).

## Conclusion

This is a small taste of the features added to Embark 4, namely the ability to use a frontend build tool of choice. However, Embark 4 is jam-packed with additional new features, which we'll detail during the Embark 4 release.

In the meantime, all the Embark 4 goodness doesn't come at too high a price in terms of breaking changes.

Upgrading to Embark 4 will be a blast. If you ever have an issue, make sure to hit us up on [Gitter](https://gitter.im/embark-framework/Lobby).
