title: Quick Start
---

### Installation

First make sure you have installed Embark, preferably using NVM. See [install instructions](index.html#Requirements)

### Create demo app

<pre><code class="shell">$ embark demo
$ cd embark_demo
</code></pre>

### Start a blockchain node or let Embark start it for you

Note: starting in Embark 3.1, the command `embark run` will automatically start a blockchain node if one isn't already running. You may, therefore, skip this step.

You can run a REAL ethereum node for development purposes:

<pre><code class="shell">$ embark blockchain
</code></pre>

Alternatively, to use an ethereum rpc simulator simply run:

<pre><code class="shell">$ embark simulator
</code></pre>

By default Embark blockchain will mine a minimum amount of ether and will only mine when new transactions come in.


If you want, you can skip this step, as `embark run`, `build` and `upload` now all start a blockchain node in a separate process if there is not one already started using the same configurations. 

### Start Embark

Then, in another command line:

<pre><code class="shell">$ embark run
</code></pre>

This will open up the embark Dashboard

![Dashboard](http://i.imgur.com/s4OQZpu.jpg)

The dashboard will tell you the state of your contracts, the environment you are using, and what Embark is doing at the moment.

**available services**

Available Services will display the services available to your dapp in green. If a service is down, then it will be displayed in red.

**logs and console**

There is a console at the bottom which can be used to interact with contracts or with Embark itself. Type ``help`` to see a list of available commands.  More commands will be added with each version of Embark.

Embark will then compile & deploy the contracts, update their JS bindings and deploy your DApp to a local server at http://localhost:8000

{% note for without the dashboard %}
if you prefer to only see the logs, you can disable the dashboard with the nodashboard option ``embark run --nodashboard``
{% endnote %}

Note that if you update your code, it will automatically be re-deployed, contracts included. There is no need to restart embark, refreshing the page on the browser will do.

