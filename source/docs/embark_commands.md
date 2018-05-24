title: Embark Commands
---

## new

``` bash
$ embark new <dappName>
```

Creates a new empty DApp project. If no `dappName` is provided, Embark will ask for the dappName.

Option | Description
--- | ---
`--simple` | create a barebones project meant only for contract development 

## demo

``` bash
$ embark demo
```

Generates a demo Embark Project with a working contract and examples of working with contracts, IPFS and Whisper.

## build

``` bash
$ embark build [environment]
```

Deploys and Builds the DApp at dist/. If no `environment` is provider embark will use `development` by default.

## run

``` bash
$ embark run [environment]
```

Deploys and Builds the DApp at `dist/`. By default will launch a dashboard and start a dev server at `http://localhost:4000/`. If no `environment` is provider embark will use `development` by default.  

Option | Description
--- | ---
`-p`, `--port` | `port` to run the dev webserver (default: 8000)
`-b`, `--host` | `host` to run the dev webserver (default: localhost)
`--noserver` | disable the development webserver
`--nodashboard` | simple mode, disables the dashboard
`--no-color` | no colors in case it's needed for compatbility purposes
`--logfile` | `filename` to output logs (default: none)

## blockchain

``` bash
$ embark blockchain [environment]
```

Takes the config at `config/blockchain.json` for the `environment` specified and starts a blockchain node. If no `environment` is provider embark will use `development` by default.

If you want, you can skip the step of running `embark blockchain`, as `embark run`, `build` and `upload` now all start a blockchain node in a separate process if there is not one already started using the same configurations.

## simulator

``` bash
$ embark blockchain [environment]
```

Takes the config at `config/blockchain.json` for the `environment` specified and starts a blockchain simulator. If no `environment` is provider embark will use `development` by default.

Option | Description
--- | ---
`-p`, `--port` | `port` to run the rpc simulator (default: 8545)
`-h`, `--host` | `host` to run the rpc simulator (default: localhost)
`-a`, `--accounts` | `num` of accounts to start the simulator (default: 10)
`-e`, `--defaultBalanceEther` | `balance` in ether to assign each test account (default: 100)
`-l`, `--gasLimit` | custom `gasLimit` (default: 8000000)

## test

``` bash
$ embark test [file]
```

Runs Tests. If `file` is not specified then it will run all the tests inside the `test/` directory.

## reset

``` bash
$ embark reset
```

Resets embarks state on this dapp including clearing cache.

## upload

``` bash
$ embark upload [platform] [environment]
```

Uploads the DApp to a decentralized storage such as IPFS. `platform` can be `ipfs` or `swarm` or another parameter if supported by a plugin. If no `environment` is provider embark will use `development` by default.

## graph

``` bash
$ embark graph
```

Generates documentation based on the smart contracts configured

## version

``` bash
$ embark version
```

Displays version information.

