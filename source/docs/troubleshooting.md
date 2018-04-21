title: Troubleshooting
---
In case you're experiencing problems with using Embark, here is a list of solutions to some frequently encountered issues. If this page doesn't help you solve your problem, try doing a search on [GitHub](https://github.com/embark-framework/embark/issues).

**TODO: add typical issues**

## node-gyp problems
node-gyp can cause problems, because it requires a C++ compiler.

If you do have problems caused by it, first follow the installation steps for your OS [here](https://github.com/nodejs/node-gyp#installation).

If you still have problems and are on Windows, try the following:
- run `npm config set msvs_version 2015` before `npm install`
- Repair Windows Build tools that the node-gyp doc made you install. If it tells you to remove a conflicting version do it. After the repair succeeded, reboot.

<!--
## YAML Parsing Error

``` plain
JS-YAML: incomplete explicit mapping pair; a key node is missed at line 18, column 29:
      last_updated: Last updated: %s
```

Wrap the string with quotations if it contains colons.

``` plain
JS-YAML: bad indentation of a mapping entry at line 18, column 31:
      last_updated:"Last updated: %s"
```

Make sure you are using soft tabs and add a space after colons.

-->
