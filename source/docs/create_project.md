title: Creating a new Embark Project
---

Once Embark is installed, you can create a new Embark project, you have many options to do so:

### Creating a Demo Project

If you are first starting & exploring Embark you can create a demo project:

<pre><code class="shell">$ embark demo
$ cd embark_demo
</code></pre>

### Creating a Blank Project

To create a brand new project you can use:

<pre><code class="shell">$ embark new &lt;YourDAppName&gt;
$ cd &lt;YourDAppName&gt;
</code></pre>

### Creating a "contracts-only" project

If you only intend to develop, test & deploy smart contracts and don't intend to develop a UI nor use other decentralized components, then you can use the `--simple` option:

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --simple
$ cd &lt;YourDAppName&gt;
</code></pre>

This will create a simple project with all components disabled except the blockchain/contracts component.


### Creating a project from a template

If you want to start from a pre-existing template, then you can use the `--template` option:

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --template angular
$ cd &lt;YourDAppName&gt;
</code></pre>

##### Using template with URL

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --template https://github.com/embark-framework/embark-vue-template
$ cd &lt;YourDAppName&gt;
</code></pre>

##### Using template with Github

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --template embark-framework/embark-typescript-template
$ cd &lt;YourDAppName&gt;
</code></pre>

It is even possible to specify the branch:

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --template git@github.com/status-im/dappcon-workshop-dapp#start-here
$ cd &lt;YourDAppName&gt;
</code></pre>