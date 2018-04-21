title: Configuring Embark
---

**TODO**

```Javascript
{
  "contracts": ["contracts/**"],
  "app": {
    "js/dapp.js": ["app/dapp.js"],
    "index.html": "app/index.html",
    "images/": ["app/images/**"]
  },
  "buildDir": "dist/",
  "config": "config/",
  "versions": {
    "web3": "1.0.0-beta",
    "solc": "0.4.17",
    "ipfs-api": "17.2.4"
  },
  "plugins": {
  }
}
```

### contracts

### pipeline

### build directory

### config

### library versions

Here you can optionaly specify the versions of the library to be used by Embark. Embark will automatically download the specific library version if necessary. It's possible to override this in other config files such as `contracts.json` on a per enviroment basis.

### plugins

