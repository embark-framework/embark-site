title: Environments
---

Embark has the concept of environments, all config files have entries for each environment and the environment can be specified in each command in the form of `embark <cmd_name> <environment>`
If no environment is specified, Embark assumes `development` to be the intended environment.

For e.g `embark run testnet` will run Embark with the configurations specified on `testnet` for each config file.
`embark run` will run Embark with the configuration specified on `development` for each config file.

`default` is a special environment whose configs applies to all environments. Each config is then merged with `default`, this way you can specify the most common options in
default, and then only override what's really needed on a per environment basis.

