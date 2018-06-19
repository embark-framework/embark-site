title: Messages
---

### Setup

By default Embark will automatically initialize EmbarkJS with the provider configured at `config/communication.json`. However if you are using EmbarkJS directly or wish to change the provider configuration on the fly you can do:

```Javascript
        EmbarkJS.Messages.setProvider('whisper')
```

### listening to messages

```Javascript
      EmbarkJS.Messages.listenTo({topic: ["topic1", "topic2"]}).then(function(message) {
        console.log("received: " + message);
      })
```

### sending messages

you can send plain text

```Javascript
      EmbarkJS.Messages.sendMessage({topic: "sometopic", data: 'hello world'})
```

or an object

```Javascript
      EmbarkJS.Messages.sendMessage({topic: "sometopic", data: {msg: 'hello world'}})
```

note: array of topics are considered an AND. In Whisper you can use another array for OR combinations of several topics e.g ``["topic1", ["topic2", "topic3"]]`` => ``topic1 AND (topic2 OR topic 3)``

### Configuration basics

Embark will check your prefered communication configuration in the file ``config/communication.json``. This file will contain the prefered configuration for each environment. With ``default`` being the configuration fields that applies to every environment. Each of those can be individually overriden in a per environment basis.

e.g :

```Javascript
    {
      "default": {
        "enabled": true,
        "provider": "whisper",
        "available_providers": ["whisper"]
      }
    }
```

options available:
  * ``enabled`` (boolean: true/false) to enable or completly disable communication support
  * ``provider`` (string: "wisper" or "orbit") desired provider to automatically connect to on the dapp. e.g in the example above, seting this to ``"whisper"`` will automaticaly add ``EmbarkJS.setProvider('whisper')`` to the generated code
  * ``available_providers`` (array: ["whisper"]) list of communication platforms to be supported on the dapp. This will affect what's available with the EmbarkJS library on the dapp so if you don't need Whisper for e.g, removing it from this will considerably reduce the file size of the generated JS code.

