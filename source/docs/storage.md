title: Storage
---

### Setup

By default Embark will automatically initialize EmbarkJS with the provider configured at `config/storage.json`. However if you are using EmbarkJS directly or wish to change the provider configuration on the fly you can do:

```Javascript
    EmbarkJS.Storage.setProvider('swarm', options);
```
Options are optional and if provided, will override the values in `storage.json`. 

For example,
```Javascript
      EmbarkJS.Storage.setProvider('ipfs', {server: 'localhost', port: '5001'});
      // OR
      EmbarkJS.Storage.setProvider('ipfs', {server: 'swarm-gateways.net', port: '80'});
```

### Save Text/Data

```Javascript
      EmbarkJS.Storage.saveText("hello world")
        .then(function(hash) {})
        .catch(function(err) {
            if(err){
              console.log("IPFS saveText Error => " + err.message);
            }
        });
```

### Retrieve Text/Data

```Javascript
      EmbarkJS.Storage.get(hash)
        .then(function(content) {})
        .catch(function(err) {
            if(err){
              console.log("IPFS get Error => " + err.message);
            }
        });
```

### Upload a file

```Html
      <input type="file">
```

```Javascript
      var input = $("input[type=file"]);
      EmbarkJS.Storage.uploadFile(input)
        .then(function(hash) {})
        .catch(function(err) {
            if(err){
              console.log("IPFS uploadFile Error => " + err.message);
            }
        });
```

### Display a file

```Javascript
      EmbarkJS.Storage.getUrl(hash);
```

### Check for storage provider availability
This will return true if the storage provider (IPFS or Swarm) is avaiable and running. 

```Javascript
      EmbarkJS.Storage.isAvailable()
        .then(isAvailable => { alert(`The storage provider is: ${isAvailable ? 'available' : 'not available'}`) })
        .catch(function(err) {
            if(err){
              console.log("Error getting storage provider availability => " + err.message);
            }
        });
```

### Configuration basics

Embark will check your prefered storage configuration in the file ``config/storage.json``. This file will contain the prefered configuration for each environment. With ``default`` being the configuration fields that applies to every environment. Each of those can be individually overriden in a per environment basis.

e.g :

```Javascript
    {
      "default": {
        "enabled": true,
        "ipfs_bin": "ipfs",
        "available_providers": ["ipfs", "swarm"],
        "upload":{
          "provider": "ipfs",
          "host": "localhost",
          "port": 5001,
          "getUrl": "http://localhost:8080/ipfs"
        },
        "dappConnection":[
          {"provider": "swarm", "host": "localhost", "port": 8500, "getUrl": "http://localhost:8500/bzz:/"},
          {"provider": "ipfs", "host": "localhost", "port": 5001, "getUrl": "http://localhost:8080/ipfs/"}
        ],
        "versions": {
          "ipfs-api": "17.2.4"
        }
      },
      "development": {
        "enabled": true,
        "provider": "ipfs",
        "host": "localhost",
        "port": 5001
      }
    }
```

Available options are:

Option | Type: `default` | Value         
--- | --- | --- 
`enabled`    | boolean: `true` | Enables or completly disables storage support
`ipfs_bin`    | string: `ipfs` | Name or desired path to the ipfs binary
`available_providers`    | array: `["ipfs", "swarm"]` | list of storages to be supported on the dapp. This will affect what's available with the EmbarkJS library on the dapp.
`upload`      | | The upload element specifies storage provider settings used for uploading your dapp.
`upload.provider`    | string: `ipfs` | desired provider to use when uploading dapp.
`upload.protocol`    | string: `http` | Storage provider protocol for upload, ie `http` or `https`
`upload.host`        | string: `localhost` | Host value used to interact with the storage provider for upload, ie `localhost` or `swarm-gateways.net`
`upload.port`        | integer: `5001` | Port value used to interact with the storage provider for upload, ie `5001` (IPFS local node) or `8500` (Swarm local node) or `80`
`upload.getUrl`      | string: `http://localhost:8080/ipfs/` | Only for IPFS. This sets the file/document retrieval URL, which is different than the host/port combination used to interact with the IPFS api.
`dappConnection`     | | List of storage providers to attempt connection to in the dapp. Each conneciton listed will be tried in order, until one is avaialable. Can also specify `$BZZ` to attempt to connect to an injected swarm object.
`dappConnection.provider` | string: `ipfs` | desired provider to use for dapp storage. 
`dappConnection.protocol`    | string: `http` | Storage provider protocol used in the dapp, ie `http` or `https`
`dappConnection.host`        | string | Host value used to interact with the storage provider in the dapp, ie `localhost` or `swarm-gateways.net`
`dappConnection.port`        | integer | Port value used to interact with the storage provider in the dapp, ie `5001` (IPFS local node) or `8500` (Swarm local node) or `80`. Can specify `false` if a port should not be included in the connection URL (ie for a public gateway like `http://swarm-gateways.net`).
`dappConnection.getUrl`      | string | Only for IPFS. This sets the file/document retrieval URL, which is different than the host/port combination used to interact with the IPFS api.
`versions`    | object | key-value hash of library and its desired version

### Using a local node

Either for IPFS or Swarm, Embark will default to use a local node for development purposes

Please note that you still need to setup the right port according to the storage platform you use.

By default, IPFS runs on port `5001` and Swarm runs of `8500`.

You can start your local storage node yourself or now you can also let Embark start the node itself in another node.

Letting Embark do it for you let's you focus on developing faster while starting it yourself gives you more flexibility.

You still need to have IPFS or Swarm installed locally for it to work, whatever the case.

**Important configurations for swarm**:

```json
{
  "development": {
    "provider": "swarm",
    "account": {
      "address": "YOUR_ACCOUNT_ADDRESS",
      "password": "PATH/TO/PASSWORD/FILE"
    },
    "swarmPath": "PATH/TO/SWARM/EXECUTABLE"
  }
}
```

### Using a public gateway

To use a public gateway (instead of running a local node) for IPFS or Swarm, use the following `config/storage.json` options:
#### IPFS
```json
"development": {
    "enabled": true,
    "provider": "ipfs",
    "host": "ipfs.infura.io",
    "port": 80,
    "protocol": "https",
    "getUrl": "https://ipfs.infura.io/ipfs/"
  }
```

#### Swarm
```json
"development": {
    "enabled": true,
    "provider": "swarm",
    "host": "swarm-gateways.net",
    "port": 80
  }
```

### Using swarm
Running a local swarm node (ie `localhost:8500`) is supported, however this has not proven to be stable yet. Instead, we recommend using swarm-gateways.net for now.
Please see the [Swarm documentation](http://swarm-guide.readthedocs.io/en/latest/runninganode.html) for more information on running a Swarm node.

### Troubleshooting <a name="troubleshooting"></a>

If you are not running your DApp on `localhost`, the CORS needs to be set:

```
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://dapptastic.com"]'
```

If running a local Swarm node, the CORS needs to be set to be used with your DApp domain using the --corsdomain http://dapptastic.com option. An example swarm command would be:

```
swarm --bzzaccount fedda09fd9218d1ea4fd41ad44694fa4ccba1878 --datadir ~/.bzz-data/ --password config/development/password --corsdomain http://localhost:8000 --ens-api ''
```

