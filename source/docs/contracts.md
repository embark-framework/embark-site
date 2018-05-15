title: Contracts
---

### Basic Contract Configuration

You can specify for each contract and environment its gas costs (in wei) and
arguments:

```Json
    # config/contracts.json
    {
      "development": {
        "gas": "auto",
        "contracts": {
          "SimpleStorage": {
            "args": [
              100
            ],
            "gas": 800000,
            "gasPrice": 5
          }
        }
      }
    }
```

If you prefer it's also possible to specify the contract arguments by their variable name instead of a list:

```Json
    # config/contracts.json
    {
      "development": {
        "contracts": {
          "SimpleStorage": {
            "args": {
              "initial_value": 100
            }
          }
        }
      }
    }
```

### Specifying Contract Dependencies

If you are using multiple contracts, you can pass a reference to another contract as ``$ContractName``, Embark will automatically replace this with the correct address for the contract.
You can also specify interfaces and choose to not deploy contracts (for e.g in case they are interfaces)

```Json
    # config/contracts.json
    {
      ...
      "development": {
        "contracts": {
          "SimpleStorage": {
            "args": [
              100,
              "$MyStorage"
            ]
          },
          "MyStorage": {
            "args": [
              "initial string"
            ]
          },
          "MyMainContract": {
            "args": [
              "$SimpleStorage"
            ]
          },
          "MyContractInteface": {
            "deploy": false
          }
        }
      }
      ...
    }
```

### Multiple Instances

You can deploy many instances of the same contract. e.g

```Json
    # config/contracts.json
    {
      "development": {
        "contracts": {
          "Currency": {
            "deploy": false,
            "args": [
              100
            ]
          },
          "Usd": {
            "instanceOf": "Currency",
            "args": [
              200
            ]
          },
          "MyCoin": {
            "instanceOf": "Currency",
            "args": [
              200
            ]
          }
        }
      }
    }
      ...
```

### Deployer Account

You can specify which Account you want to deploy a contract from. This can be specified using "from" or "fromIndex" parameters.

| "from" - should be account address string.
| "fromIndex" - should be index in accounts array as retrieved by web3.eth.getAccounts() .

If both "from" and "fromIndex" are specified, the "from" will be used.

Example:

```Json

          # config/contracts.json
          {
            "development": {
              "contracts": {
                "Currency": {
                  "deploy": true,
                  "from": '0xfeedaa0e295b09cd84d6ea2cce390eb443bcfdfc',
                  "args": [
                    100
                  ]
                },
                "MyStorage": {
                  "fromIndex": 0,
                  "args": [
                    "initial string"
                  ]
                },
              }
            }
          }
            ...
```

### Using accounts in a wallet

You can use your own account in a wallet which will then be used for the contract deploy, for example.

Using this feature in the development environment requires you to fund the account yourself. This will be fixed in a later release.

```js
{
  "testnet": {
      "deployment": {
        "accounts": [
          {
            "privateKey": "your_private_key"
          },
          {
            "privateKeyFile": "path/to/file" // You can put more than one key, separated by , or ;
          },
          {
            "mnemonic": "12 word mnemonic",
            "addressIndex": "0", // Optionnal. The index to start getting the address
            "numAddresses": "1", // Optionnal. The number of addresses to get
            "hdpath": "m/44'/60'/0'/0/" // Optionnal. HD derivation path
          }
        ]
      }
  }
}
```

### Static Addresses

Contracts addresses can be defined, If an address is defined the contract wouldn't be deployed but its defined address will be used instead.

```Json

    # config/contracts.json
    {
      ...
      "development": {
        "contracts": {
          "UserStorage": {
            "address": "0x123456"
          },
          "UserManagement": {
            "args": [
              "$UserStorage"
            ]
          }
        }
      }
      ...
    }
```

### onDeploy Actions

You can specify actions to do after the deployment of a contract using the "onDeploy" parameter.

| "onDeploy" - should be an array of javascript instructions that will be evaluated and executed

```Json

    # config/contracts.json
    {
      "development": {
        "gas": "auto",
        "contracts": {
          "SimpleStorage": {
            "args": [
              100
            ],
            "onDeploy": ["SimpleStorage.methods.set(150).send()"]
          }
        }
      }
    }
```

### afterDeploy Actions

You can specify actions to do after ALL contracts have been deployed by using the "afterDeploy" parameter.

| "afterDeploy" - should be an array of javascript instructions that will be evaluated and executed

```Json
    # config/contracts.json
    {
      "development": {
        "gas": "auto",
        "contracts": {
          "SimpleStorage": {
            "args": [
              100
            ]
          },
          "afterDeploy": [
            "SimpleStorage.methods.set(150).send()"
          ]
        }
      }
    }
```

### Specify contract file

By default embark will look for the contracts inside the folder defined in "contracts"` property in embark.json.
However it's possible to specify the contract filepath:

```Json
    # config/contracts.json
    {
      "development": {
        "gas": "auto",
        "contracts": {
          "SimpleStorage": {
            "file": "./some_folder/simple_storage.sol",
            "args": [
              100
            ]
          }
        }
      }
    }
```

You can even specify files on Git, Github or over HTTP(S):
```Json
    # config/contracts.json
    {
      "development": {
        "contracts": {
          "ERC725": {
            "file": "git://github.com/status/contracts/contracts/identity/ERC725.sol#develop"
          },
          "ERC725": {
            "file": "github.com/status/contracts/contracts/identity/ERC725.sol"
          },
          "Ownable": {
            "file": "https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/ownership/Ownable.sol"
          }
        }
      }
    }
```

### Specify contract file from package

It's also possible to specify a contract file from a npm package:

```Json
    # config/contracts.json
    {
      "development": {
        "gas": "auto",
        "contracts": {
          "ERC20": {
            "file": "zeppelin-solidity/contracts/token/ERC20/ERC20.sol",
          }
        }
      }
    }
```

### Importing files in contracts

If using solidity it's also possible to directly import contract files inside the dapp from folders that are not explicity defined in the "contracts" propery of embark.json.

```Javascript
import "another_folder/another_test.sol";
```

You can also import a contract file from a npm package:

```Javascript
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
```

You can even use files directly from Git, Github or directly from HTTP(S):

```Javascript
import "git://github.com/status/contracts/contracts/identity/ERC725.sol#develop";
import "github.com/status/contracts/contracts/identity/ERC725.sol";
import "https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/ownership/Ownable.sol";
```

