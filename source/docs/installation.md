title: Installation
---

## Prerequisites

In order to make Embark work on our computer, we need to have some tools installed first. Make sure you have the following ready and in the correct version:

- [Node](#Node)
- [Ethereum Client](#Ethereum-Client-Optional)
- [IPFS](#IPFS-Optional)

Once done, go ahead and [install Embark](#Installing-Embark).

### Node

Please install [Node.js](http://nodejs.org/) in version 8.11.3 LTS or higher.

{% note info Quick tip: %}
**We recommend installing Node using the [Node Version Manager](https://github.com/creationix/nvm/blob/master/README.md).**  This is because it makes it very easy to install different versions of Node in isolated environments that don't require users to [change their permissions](https://docs.npmjs.com/getting-started/fixing-npm-permissions) when installing packages. Find instructions on how to install NVM [here](https://github.com/creationix/nvm/blob/master/README.md#install-script).

Once that is done, we can install and select a specific Node version or use the `--lts` option to get the latest version with long term support like this:

<pre><code class="shell">$ nvm install --lts
$ nvm use --lts
</code></pre>

{% endnote %}

### IPFS (Optional)

IPFS can be used to distribute our application's content on the decentralized IPFS nodes. This can be skipped in case this isn't planned, however we do recommend it. Checkout IPFS' [installation guide](https://docs.ipfs.io/introduction/install/) to learn how to install IPFS on our local machine.

To verify that the installation was successful, simply run the following command:

<pre><code class="shell">$ ipfs --version</code></pre>

This outputs something like

<pre><code class="shell">ipfs version 0.4.17</code></pre>

### Ethereum Client (Optional)

Embark can spin up an Ethereum node for us. To make this happen, an Ethereum client has to be installed on our machine as well. Embark already comes with [Ganache CLI](https://truffleframework.com/ganache), a blockchain node emulator, which is accessible via [Embark's simulator](embark_commands.html#simulator) command.

In case we want to run a real node, [geth](https://geth.ethereum.org/) is a pretty good one. Check out the [installation guide](https://ethereum.github.io/go-ethereum/install/) for our platform and verify our installation with:

<pre><code class="shell">$ geth version</code></pre>

Which should result in an output that looks like this (note that the exact version numbers may be different):
<pre><code class="shell">Geth
Version: 1.8.15-stable
Git Commit: 89451f7c382ad2185987ee369f16416f89c28a7d
Architecture: amd64
Protocol Versions: [63 62]
Network Id: 1
Go Version: go1.10.4
Operating System: darwin
GOPATH=
GOROOT=/Users/travis/.gimme/versions/go1.10.4.darwin.amd64
</code></pre>

## Installing Embark

Alright, let's install Embark so we can build our first application. As mentioned earlier, if anything is unclear or you run into problems, make sure to reach out to us on our dedicated channels, [submit an issue on  GitHub](https://github.com/embark-framework/embark/issues), or take a look at our [troubleshooting guide](troubleshooting.html).

We can install Embark using the Node Package Manager (no worries, that one comes with Node), like this:

<pre><code class="shell">$ npm -g install embark</code></pre>

After that, `embark` should be available as a global command in our terminal of choice. Let's verify this by running the following command:

<pre><code class="shell">$ embark --version</code></pre>

At the time of writing this guide, the output looked like this:

<pre><code class="shell">3.2.1</code></pre>

## Installing Embark @next

While running `npm install -g embark` will give us the latest and great stable version of Embark, we're sometimes interested in trying out features that are in active development. The Embark team maintains a `next` distribution tag on npm that can be used to install versions of Embark that aren't stable.

<pre><code class="shell">$ npm -g install embark@next</code></pre>

## Installing Embark's latest GitHub version

If we're interested in getting whatever has landed last in the code base, we can install directly from Embark's GitHub repository like this:

<pre><code class="shell">$ npm -g install embark-framework/embark</code></pre>

{% note warn Warning: %}
Installations with `@next` or directly from the `master` branch on GitHub are considered unstable and may have bugs, so please proceed with caution.
{% endnote %}

Awesome! We're all set up. Let's build our first decentralized application!

