title: Embark
layout: index
---

## Smart Contracts

``` javascript
import Token from "Embark/contracts/Token"

Token.methods.transfer("0x123", 100000).send();
```

## Decentralized Storage

``` javascript
import EmbarkJS from 'Embark/EmbarkJS'

EmbarkJS.Storage.saveText("hello world").then(function(hash) {});

EmbarkJS.Storage.get(hash).then(function(content) {});
```

## Decentralized Communication

``` javascript
import EmbarkJS from 'Embark/EmbarkJS'

EmbarkJS.Messages.listenTo({topic: ["topic1", "topic2"]}).then((data) => {
  console.log("received: " + data);
});

EmbarkJS.Messages.sendMessage({topic: "topic1", data: {msg: 'hello world'}})
```

## Deployment

``` bash
$ embark upload ipfs -e livenet
```

## And much more

* Testing
* easily upload and download files to a decentralized storage
* powerfull plugin system

