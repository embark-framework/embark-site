title: Creating apps with Embark
---

Once Embark is installed, there are different ways to create a new decentralized application. Whether we intent to create an application that uses only Smart Contracts, or we want to take advantage of other decentralized features like storages and messaging, Embark provides options and templates for various scenarios. Let's take a look!

## Using the `demo` command

As discussed in our [quickstart guide](quick-start.html), the fastest way to get up and running with Embark is using its `demo` command. This will scaffold a new demo application and its needed environment in a folder called `embark_demo`. The demo application lets you play with Embark's APIs through a pre-built web interface.

<pre><code class="shell">$ embark demo</code></pre>

## Creating a new app

If you prefer starting entirely from scratch, while still getting a ready to use environment, Embark's `new` command has got you covered. Similar to the `demo` command, it will scaffold a new project folder. However, it will not include the demo application. The green field is all yours.

<pre><code class="shell">$ embark new &lt;YourDAppName&gt;</code></pre>

## Creating apps from templates

Another possible scenario to start from is taking advantage of a template. Embark [comes with templates](/templates) for various environments and frameworks, but you can also use any template created by the community. In order to create a new app from a template, use the `--template` option and either specify a supported template name, or a Git host URL.

The following example creates a new application from [Embark's TypeScript template](https://github.com/embark-framework/embark-typescript-template):

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --template typescript</code></pre>

To learn more about supported templates, head over to our [templates](/templates) or look out for `embark-[template_name]-template` [repositories](https://github.com/embark-framework?utf8=%E2%9C%93&q=template&type=&language=). 

Templates can also be fetched from external resources as long as they can be referred to via Git host URLs. The following example fetches a template from a GitHub repository and uses that to create that app:

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --template https://github.com/embark-framework/embark-vue-template</code></pre>

In fact, in case of GitHub, the same can be done with the username/repository shortcut:

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --template embark-framework/embark-vue-template</code></pre>

It is even possible to specify the branch by appending a `#` and the branch name you're interested in:

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --template status-im/dappcon-workshop-dapp#start-here</code></pre>

## Creating "contracts-only" apps

Sometimes, all we really want to do is creating, developing and deploying Smart Contracts without introducing an actual front-end that talks to them. Embark lets us scaffold apps that come with the most minimal setup needed to build and deploy our Smart Contracts, using the `--simple` option.

The following command will create a project with all Embark services disabled except the blockchain service.

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --simple</code></pre>
