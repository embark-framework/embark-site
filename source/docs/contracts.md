title: Contracts
---

### Basic Contract Configuration

You can specify for each contract and environment its gas costs and
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

