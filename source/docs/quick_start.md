title: Quick Start
---

In this guide we'll explore how easy it is to quickly get up and running with Embark to build our first decentralized application. We assume you've been through our [installation guide](installation.html) and have everything you need to get started. If not, please head over there first and get your machine ready.

## Creating your first app

In order to get results as quickly as possible, Embark comes with a `demo` command that scaffolds and sets up a complete application for us to play with. Open up a terminal of your choice and run:

<pre><code class="shell">$ embark demo
$ cd embark_demo
</code></pre>

This will create a demo application. Feel free to look around to get familiar with the project's structure, but don't worry. We'll take a closer look at it later in one of our [dedicated guides](structure.html).

## Running your app

The fastest way to get your app running is to use Embark's `run` command. It takes care of a lot of things, such as spinning up an Ethereum and IPFS node, or keeping an eye on file changes to recompile your code. There's other ways to [run your app](running_apps.html), in case you need more control over different processes, but let's not get ahead of ourselves.

<pre><code class="shell">$ embark run</code></pre>

Once executed, we'll notice that Embark opens up a dashboard view inside our terminal. This is the place where we monitor running processes such as compilation of our sources as well as deployments. As everything in Embark, the dashboard usage is configurable. If we prefer Embark to just output logs of whatever it's doing, this can be easily done by running the same command with the `--nodashboard` option.

Notice that the dashboard comes with sections for **Contracts**, **Environment**, **Status**, **Available Services**, **Logs** and **Console**. While most of them are self explanatory, we'll take a closer look at those in the [dashboard guide](dashboard.html).

![Dashboard](/assets/images/embark-dashboard.png)

For now, let's focus on what has happened in the meantime. Embark has compiled and deployed the Smart Contracts that come with the demo application to a custom blockchain on your local machine. It has also compiled the web app that's part of the demo and deployed that to a local web server, which is listening on `http://localhost:8000`. In fact, Embark has probably already opened a browser window for you. 

If not, give it a try yourself and open [localhost:8000](http://localhost:8000) in your browser of choice!

## Getting help

**Congratulations!** You've just created your first decentralized application. Now it's a good time to explore what else Embark has to offer. To get started, type `help` into the running console to get a list of commands you can run inside the dashboard.

Also, make sure to check out the other guides and let us know if you miss anything! If you run into any problems, the [guide on troubleshooting](troubleshooting.html) is here to help.


