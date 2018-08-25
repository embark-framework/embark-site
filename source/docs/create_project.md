title: Creating a new Embark Project
---

Once Embark is installed, you can create a new Embark project, you have many options to do so:

### Creating a Blank Project

To create a brand new project you can use:

<pre><code class="shell">$ embark new &lt;YourDAppName&gt;
$ cd &lt;YourDAppName&gt;
</code></pre>

### Creating a Demo Project

If you are first starting & exploring Embark you can create a demo project:

<pre><code class="shell">$ embark demo
$ cd embark_demo
</code></pre>

### Creating a "contracts-only" project

If you only intend to develop, test & deploy smart contracts and don't intend to develop an UI nor use other decentralized components then you can use the `--simple` option to create 

<pre><code class="shell">$ embark new &lt;YourDAppName&gt; --simple
$ cd &lt;YourDAppName&gt;
</code></pre>

This will create a simple project with all components disabled except the blockchain/contracts component.
