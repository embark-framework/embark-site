title: Storage
---

### Setup

By default Embark will automatically initialize EmbarkJS with the provider configured at `config/storage.json`. However if you are using EmbarkJS directly or wish to change the provider configuration on the fly you can do:

```Javascript
    EmbarkJS.Storage.setProvider('ipfs',{server: 'localhost', port: '5001'})
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

### Configuration basics

Embark will check your prefered storage configuration in the file ``config/storage.json``. This file will contain the prefered configuration for each environment. With ``default`` being the configuration fields that applies to every environment. Each of those can be individually overriden in a per environment basis.

e.g :

```Javascript
    {
      "default": {
        "enabled": true,
        "ipfs_bin": "ipfs",
        "provider": "ipfs",
        "available_providers": ["ipfs"],
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

options available:
  * ``enabled`` (boolean: true/false) to enable or completly disable storage support
  * ``ipfs_bin`` (string) name or desired path to the ipfs binary
  * ``provider`` (string: "ipfs") desired provider to automatically connect to on the dapp. e.g in the example above, seting this to ``"ipfs"`` will automaticaly add ``EmbarkJS.setProvider('ipfs', {server: 'localhost', 5001})`` to the generated code
  * ``available_providers`` (array: ["ipfs"]) list of storages to be supported on the dapp. This will affect what's available with the EmbarkJS library on the dapp.
  * ``host`` and ``port`` of the ipfs node to connect to.
  * ``versions`` (object) key-value hash of library and its desired version

### Using a public gateway

TODO

### Troubleshooting

If not using localhost, the cors needs to be set as `ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["your-host-name-port"]`

