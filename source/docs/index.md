title: Documentation
---
Welcome to the Embark documentation. If you encounter any problems when using Embark, have a look at the  [troubleshooting guide](troubleshooting.html), raise an issue on [GitHub](https://github.com/embark-framework/embark/issues) or ask in the [Gitter Chatroom](https://gitter.im/embark-framework/Lobby).

## What is Embark?

Embark is a fast, simple and powerful framework to develop and deploy Decentralized Applications (DApps). 

Embark currently integrates with EVM blockchains (Ethereum), Decentralized Storages (IPFS), and Decentralized communication platforms (Whisper and Orbit). Swarm is supported for deployment.

With Embark you can:

**Blockchain (Ethereum)**
* Automatically deploy contracts and make them available in your JS code. Embark watches for changes, and if you update a contract, Embark will automatically redeploy the contracts (if needed) and the dapp.
* Contracts are available in JS with Promises.
* Do Test Driven Development with Contracts using Javascript.
* Keep track of deployed contracts; deploy only when truly needed.
* Manage different chains (e.g testnet, private net, livenet)
* Easily manage complex systems of interdependent contracts.

**Decentralized Storage (IPFS)**
* Easily Store & Retrieve Data on the DApp through EmbarkJS. Including uploading and retrieving files.
* Deploy the full application to IPFS or Swarm.


**Decentralized Communication (Whisper, Orbit)**
* Easily send/receive messages through channels in P2P through Whisper or Orbit.

**Web Technologies**
* Integrate with any web technology including React, Foundation, etc..
* Use any build pipeline or tool you wish, including grunt, gulp and webpack.


## Installation

It only takes a few minutes to set up Embark. If you encounter a problem and can't find the solution here, please [submit a GitHub issue](https://github.com/embark-framework/embark/issues) and We'll try to solve it.

### Requirements

Installing Embark is quite easy. However, you do need to have a couple of other things installed first:

- [Node.js](http://nodejs.org/) 8.11.3 LTS or higher

After installing nodejs you can install embark with:

``` bash
$ npm install -g embark
```

### With Ethereum Support

If you want to use Embark with Ethereum and want embark to run a node for you (with the ``embark blockchain`` command), then you need to install [Go-Ethrereum](https://geth.ethereum.org/) 1.6.7 or higher.

On macOS:

``` bash
$ brew tap ethereum/ethereum
$ brew install ethereum
```

On linux:

``` linux
$ sudo add-apt-repository -y ppa:ethereum/ethereum
$ sudo apt-get update
$ sudo apt-get install ethereum
```

Alternatively you can also install a simulator such as testrpc:

``` bash
$ npm -g install ethereumjs-testrpc
```

### With IPFS Support

To use IPFS you need first to install a IPFS node and run it. There two available, go-ipfs and js-ipfs.

**GO-IPFS**

Instalation instructions are available [here](https://github.com/ipfs/go-ipfs#install).

Once installed and setup you will need to make sure the headers are setup
properly for your app.

``` bash
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin "[\"http://example.com\"]"
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials "[\"true\"]"
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods "[\"PUT\", \"POST\", \"GET\"]"
```

You would want to launch it with: ``ipfs daemon --enable-pubsub-experiment``

**JS-IPFS**

While it's not 100% on parity with GO-IPFS it seems good enough for most use cases. You can install it with:

``` bash
$ npm i -g ipfs
```

To launch you would need to use ``jsipfs`` instead ``ipfs``

