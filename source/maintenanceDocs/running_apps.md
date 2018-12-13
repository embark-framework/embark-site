title: Running apps
---

While running Embark applications is pretty straight forward, there are some additional options we can take advantage of to change how our application is run. Whether we want Embark to automatically open a browser, open its dashboard or even make our app connect to different blockchains. This guide explores how this is done.

## Using the `run` command

If you've read the [quickstart](quick_start.html) you're already aware that running an application is done by simply executing `embark run` within your project:

<pre><code class="shell">$ embark run</code></pre>

By default, this will make Embark do a couple of things:

- It initializes Embark
- It starts the dashboard
- It loads plugins
- It spins up a blockchain and IPFS client, a web server and other necessary services
- It compiles and deploys your app
- It monitors running processes and recompiles and redeploys your app if needed

Most of the time, using the `run` command is all what we need to work on our Embark project, but as mentioned above, we can take a bit more control over running our application.

## Running an app without the dashboard

While the dashboard gives us a great overview of all the processes and services that Embark manages for us, it's not required to start it every single time along with compiling and deploying our app. If we don't need the dashboard, we can prevent Embark from starting it by using the `--nodashboard` option:

<pre><code class="shell">$ embark run --nodashboard</code></pre>

When running the command with `--nodashboard`, Embark will fallback to only use standard log outputs, which are the same that we get in the **Logs** panel within the dashboard.

## Running an app without opening a browser

In order to get up and running as fast as possible, Embark also takes care of opening a new browser window that connects to the web server to load our application's client. While this is quite convenient, sometimes we don't need a browser window to work on our app. This is the case when we're for example only interested in developing Smart Contracts, without creating a front-end.

If we don't want Embark to open a browser for us, all we have to do is using the `--nobrowser` option like this:

<pre><code class="shell">$ embark run --nobrowser</code></pre>

## Running an app without starting a web server

If we aren't interested in Embark starting a web server in the first place, we can easily turn it off by using the `--noserver` option:

<pre><code class="shell">$ embark run --noserver</code></pre>

## Running apps in different modes

Embark comes with different "modes" when building applications. `embark run` uses the `development` mode by default. However, this can be overwritten using the `--pipeline` option. The following command run our application in `production` mode.

<pre><code class="shell">$ embark run --pipeline production</code></pre>

For more information about modes, head over to our guide on [building apps](pipeline_and_webpack.html).

## Switching environments

Embark allows for configuring different environments to run our app against. This can be useful if we want to deploy our app to test networks or even private networks. In order to run our application in a specified environment, we first have to add a dedicated configuration to our project's `blockchain.js` file. 

Depending on how you initialized your application, it may have already multiple environments configured. Here's what a sample test network environment could look like:

<pre><code class="javascript">// config/blockchain.js

modules.exports = {
  ...
  testnet: {
    networkType: "testnet",
    syncMode: "light",
    account: {
      password: "config/testnet/password"
    }
  },
  ...
}</code></pre>

For more information on configuring your Embark application, head over to the [general configuration guide](configuration.html).

Running an application in a different environment is just a matter of specifying the environment's name as part of the run command:

<pre><code class="shell">$ embark run [environment]</code></pre>

So in case we want to run our app against the test network environment described above, this could be achieved by running:

<pre><code class="shell">$ embark run testnet</code></pre>

## Starting a blockchain separately

Sometimes we might want to have more control over the different processes involved when running our application with Embark. One of those things is to spin up a blockchain first and then have `embark run` connect to it. This enables us to stop and restart the blockchain process, without stopping Embark from doing its work.

Embark comes with a `blockchain` command that does exactly that:

<pre><code class="shell">$ embark blockchain</code></pre>

When this is executed before Embark is run within a project, the run command will skip spinning up a blockchain node itself and connect to the existing process. Similar to the `run` command, the `blockchain` command also allows to specify an environment:

<pre><code class="shell">$ embark blockchain testnet</code></pre>

By default Embark blockchain will mine a minimum amount of ether and will only mine when new transactions come in.

## Using the blockchain simulator

Another feature of Embark is to start a **simulated** blockchain. This can be useful for testing purposes as there's no need to wait for transactions to be mined. You might have heard of [Ganache CLI](https://truffleframework.com/docs/ganache/quickstart), which is a great project that implements such a simulated blockchain.

Embark integrates perfectly with this existing tool chain. To start a simulated blockchain, all we have do is to use the `simulator` command:

<pre><code class="shell">$ embark simulator</code></pre>

