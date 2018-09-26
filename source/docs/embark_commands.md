title: Embark Commands
---

## new

<pre><code class="shell">$ embark new dappName</code></pre>

Creates a new empty DApp project. If no `dappName` is provided, Embark will ask for the dappName.

Option | Description
--- | ---
`--simple` | create a barebones project meant only for contract development
`--template` | download a template using a known name or a git host URL

The `--template` option supports several URL styles and shortcuts for git hosts:

<pre>  git@github.com:ghuser/repo_name</pre>
<pre>  https://github.com/ghuser/repo_name</pre>
<pre>  github:ghuser/repo_name</pre>
<pre>  ghuser/repo_name</pre>

It's possible to append a branch name to any of the above, for example:

<pre>  https://github.com/ghuser/repo_name#branch_name</pre>
<pre>  ghuser/repo_name#branch_name</pre>

Bitbucket and GitLab URLs and shortcuts are also supported, for example:

<pre>  bitbucket:bbuser/repo_name#branch_name</pre>
<pre>  gitlab:gluser/repo_name#branch_name</pre>

A short name can be used for templates maintained in the Embark GitHub organization, for example:

<pre>  embark new --template typescript</pre>

Please see our list of [officially supported templates](/templates/).

## demo

<pre><code class="shell">$ embark demo</code></pre>

Generates a demo Embark Project with a working contract and examples of working with contracts, IPFS and Whisper.

## build

<pre><code class="shell">$ embark build [environment]</code></pre>

Deploys and Builds the DApp at dist/. If no `environment` is provider embark will use `development` by default.

## run

<pre><code class="shell">$ embark run [environment]</code></pre>

Deploys and Builds the DApp at `dist/`. By default will launch a dashboard and start a dev server at `http://localhost:8000/`. If no `environment` is provider embark will use `development` by default.

Option | Description
--- | ---
`-p`, `--port` | `port` to run the dev webserver (default: 8000)
`-b`, `--host` | `host` to run the dev webserver (default: localhost)
`--noserver` | disable the development webserver
`--nodashboard` | simple mode, disables the dashboard
`--nobrowser` | prevent the development webserver from automatically opening a web browser
`--no-color` | no colors in case it's needed for compatbility purposes
`--logfile` | `filename` to output logs (default: none)

## eject-webpack

<pre><code class="shell">$ embark eject-webpack</code></pre>

Copies Embark's default `webpack.config.js` file into your DApp so that you can customize it. If a file named `webpack.config.js` is present in your top-level DApp directory, Embark will use your webpack config file instead of its own.

## blockchain

<pre><code class="shell">$ embark blockchain [environment]</code></pre>

Takes the config at `config/blockchain.json` for the `environment` specified and starts a blockchain node. If no `environment` is provider embark will use `development` by default.

If you want, you can skip the step of running `embark blockchain`, as `embark run`, `build` and `upload` now all start a blockchain node in a separate process if there is not one already started using the same configurations.

## simulator

<pre><code class="shell">$ embark simulator [environment]</code></pre>

Takes the config at `config/blockchain.json` for the `environment` specified and starts a blockchain simulator. If no `environment` is provider embark will use `development` by default.

Option | Description
--- | ---
`-p`, `--port` | `port` to run the rpc simulator (default: 8545)
`-h`, `--host` | `host` to run the rpc simulator (default: localhost)
`-a`, `--accounts` | `num` of accounts to start the simulator (default: 10)
`-e`, `--defaultBalanceEther` | `balance` in ether to assign each test account (default: 100)
`-l`, `--gasLimit` | custom `gasLimit` (default: 8000000)

## test

<pre><code class="shell">$ embark test [file]</code></pre>

Runs Tests. If `file` is not specified then it will run all the tests inside the `test/` directory.

Option | Description
--- | ---
`-n`, `--node` | node for running the tests (default: vm)
`-d`, `--gasDetails` | print the gas cost for each contract deployment when running the tests
`-c`, `--coverage` | generate a coverage report after running the tests (vm only)

The `--node` option supports several values:

Value | Description
--- | ---
`vm` | start and use an Ethereum simulator (ganache)
`embark` | use the node of a running embark process
`<endpoint>` | connect to and use the specified node

Example of endpoint usage: `embark test --node ws://localhost:8556`

## reset

<pre><code class="shell">$ embark reset</code></pre>

Resets embarks state on this dapp including clearing cache.

## upload

<pre><code class="shell">$ embark upload [platform] [environment]</code></pre>

Uploads the DApp to a decentralized storage such as IPFS. `platform` can be `ipfs` or `swarm` or another parameter if supported by a plugin. If no `environment` is provider embark will use `development` by default.

## graph

<pre><code class="shell">$ embark graph</code></pre>

Generates documentation based on the smart contracts configured

## version

<pre><code class="shell">$ embark version</code></pre>

Displays version information.
