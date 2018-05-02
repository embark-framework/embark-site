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

### Check for storage provdier availability
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
        "provider": "ipfs",
        "available_providers": ["ipfs", "swarm"],
        "host": "localhost",
        "port": 5001,
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
| Option        | Type (default) | Value         |
|:------------- |:---------------|:--------------|
| `protocol`    | string (`http`)| Storage provider protocol, ie `http` or `https` |
| `host`        | string (`localhost`) | Host value used to interact with the storage provider, ie `localhost` or `swarm-gateways.net`      |
| `port`        | integer (`5001`) | Port value used to interact with the storage provider, ie `5001` (IPFS local node) or `8500` (Swarm local node) or `80`      |
| `getUrl`      | string (`http://localhost:8080/ipfs/` | Only for IPFS. This sets the file/document retrieval URL, which is different than the host/port combination used to interact with the IPFS api.      |
| `enabled`    | boolean: `true` | Enables or completly disables storage support |
| `ipfs_bin`    | string (`ipfs`)| Name or desired path to the ipfs binary |
| `provider`    | string (`ipfs`)| desired provider to automatically connect to on the dapp. e.g in the example above, setting this to ``"ipfs"`` will automaticaly add ``EmbarkJS.setProvider('ipfs', {server: 'localhost', 5001})`` to the generated code (assuming `host` is set to `localhost` and `port` is set to `5001`). |
| `available_providers`    | array (`["ipfs", "swarm"]`) | list of storages to be supported on the dapp. This will affect what's available with the EmbarkJS library on the dapp. |
| `versions`    | object | key-value hash of library and its desired version |

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
    "provider": "ipfs",
    "host": "swarm-gateways.net",
    "port": 80
  }
```

### Using swarm
Running a local swarm node (ie `localhost:8500`) is supported, however this has not proven to be stable yet. Instead, we recommend using swarm-gateways.net for now.
Please see the [Swarm documentation](http://swarm-guide.readthedocs.io/en/latest/runninganode.html) for more information on running a Swarm node.

### Troubleshooting

If you are not running your DApp on `localhost`, the CORS needs to be set:
```
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://dapptastic.com"]
```

If running a local Swarm node, the CORS needs to be set to be used with your DApp domain using the  ```--corsdomain http://dapptastic.com``` option. An example swarm command would be:
```
swarm --bzzaccount fedda09fd9218d1ea4fd41ad44694fa4ccba1878 --datadir ~/.bzz-data/ --password config/development/password --corsdomain http://localhost:8000 --ens-api ''
```
