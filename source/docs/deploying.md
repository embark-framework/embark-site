title: Deploying DApps to IPFS and Swarm
---
To upload your Dapp to IPFS or Swarm, first ensure you have correctly set up your dApp's `storage.json` config to specify the preferred [storage configuration settings](./storage.html)</a>, namely `provider`, `host`, `port`, and `getUrl`.

Once the config is set, run
```
embark upload
```
If you want to deploy to the livenet, just configure your account in `config/blockchain.json` under the `livenet` environment. Then, you can deploy to that chain with the following command:
```
embark upload livenet
```

Deploying to IPFS
=================
To deploy a dapp to a local IPFS node:
1. First [run a local IPFS node](https://ipfs.io/docs/getting-started/).
2. Configure your `storage.json` config with the correct settings, ie
```
    "development": {
      "enabled": true,
      "provider": "ipfs",
      "host": "localhost",
      "port": 5001,
      "getUrl": "http://localhost:8080/ipfs/"
    }
```
3. Run `embark upload`

To deploy a dapp to the public IPFS gateway:
1. Configure your `storage.json` config with the correct settings, ie
```
    "development": {
      "enabled": true,
      "provider": "ipfs",
      "host": "ipfs.infura.io",
      "port": 80,
      "protocol": "https"
      "getUrl": "https://ipfs.infura.io/ipfs/"
    }
```
2. Run `embark upload` 

Please see the [Storage troubleshooting](./storage#troubleshooting) to resolve CORS issues.

Deploying to SWARM
==================
To deploy a dapp to a local Swarm node:
1. First [run a local Swarm node](http://swarm-guide.readthedocs.io/en/latest/runninganode.html).
2. Configure your `storage.json` config with the correct settings, ie
```
    "development": {
      "enabled": true,
      "provider": "swarm",
      "host": "localhost",
      "port": 8500,
      "getUrl": "http://localhost:8500/bzzr:/"
    }
```
3. Run `embark upload` 

To deploy a dapp to the public IPFS gateway:
1. Configure your `storage.json` config with the correct settings, ie
```
    "development": {
      "enabled": true,
      "provider": "swarm",
      "host": "swarm-gateways.net",
      "port": 80
    }
```
2. Run `embark upload`

Please see the [Storage troubleshooting](./storage#troubleshooting) to resolve CORS issues.

Associating to an ENS domain
==================

You can specify the `--ens` option when uploading to associate the upload hash to an ENS domain.

Eg: `embark upload --ens=embark.eth` will upload your Dapp to IPFS or Swarm (depending on your config. See above) and then associate to the domain.
This means that going to `embark.eth` will then show you your Dapp.

*Important*: You need to be the owner of that domain for it to work.


