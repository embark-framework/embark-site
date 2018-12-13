title: Messages Configuration
---

### Configuration basics

Embark will check your preferred communication configuration in the file ``config/communication.js``. This file will contain the preferred configuration for each environment, with ``default`` being the configuration that applies to every environment. Each of those fields can be individually overridden on a per environment basis.

E.g. :

<pre><code class="javascript">// config/communication.js
module.exports = {
  "default": {
    "enabled": true,
    "provider": "whisper",
    "available_providers": ["whisper"]
  }
}
</code></pre>

options available:
  * ``enabled`` (boolean: true/false) to enable or completely disable communication support
  * ``provider`` (string: "wisper" or "orbit") desired provider to automatically connect to in the dapp. e.g. in the example above, setting this to ``"whisper"`` will automaticaly add ``EmbarkJS.setProvider('whisper')`` to the generated code
  * ``available_providers`` (array: ["whisper"]) list of communication platforms to be supported in the dapp. This will affect what's available with the EmbarkJS library in the dapp so if you don't need Whisper for example, removing it from this will considerably reduce the file size of the generated JS code.

