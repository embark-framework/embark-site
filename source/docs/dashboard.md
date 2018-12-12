title: Using the dashboard
---

Embark provides a very useful dashboard view that aims to make it easier for developers to keep track of things, such as running services, compilation and deployments. In this guide, we'll take a closer look at the dashboard and its features.

## Overview

Embark spins up the dashboard view automatically for us, whenever we run `embark run` inside an Embark project. Here's what it looks like:

![Dashboard](/assets/images/embark-dashboard.png)

The dashboard is separated into different sections, each with their own responsibility. The sections are:

- **Contracts** - This section shows you not only all the Smart Contracts within your project, but also their status on whether they are being deployed at the moment or not. Notice that, as we make changes to our Smart Contracts, the dashboard will reflect the automatic redeployment in this section as well, making it very easy to stay on top of things.

- **Environment** - This is the name of the [environment](environments.html) we're running Embark in at the moment. If we don't specify an environment when running `embark run`, Embark will default to `development`.

- **Status** - As mentioned, Embark watches for changes in our application's source code and will recompile, rebuild and redeploy components accordingly. The status section tells us what status Embark is currently in. Which could be one of the following:

  - **Compiling** - Compiles application's Smart Contracts
  - **Building** - Builds application's front-end
  - **Ready** - Ready and IDLE

- **Available Services** - This section displays all services available to our application. If a service is down or unreachable, it will show up in red.

- **Logs and Console** - While the logs section simply prints out all of Embark's output, the console can be used to either interact with our application's Smart Contracts or Embark itself. Use the `help` command to get a list of all available commands supported by Embark's console.

## Running without a dashboard

Embark can be run without spinning up the dashboard view using the `--nodashboard` option. Head over to our guide on [running apps](running_apps.html#Running-an-app-without-the-dashboard) for more information.

## Running only the console

This command is similar to `embark run --nodashboard`, but it will still spin up a console for you to interact with. Just do `embark console`.

Contrarily to `embark run`, the `console` command does not start a webserver. However, if you started Embark without a dashboard (with `--nodashboard`), but then realize you'd like to interact with Embark or contracts, you just have to run `embark console` and it will connect to your already running Embark instance and spawn a console for you.

## Using `await` in the console

`await` is an ES6 keyword that is very useful. It let's us wait for a promise to resolve and simply returns the result.

In both the dashboard's console and `embark console`'s console, you can use `await` for Promise-based calls, like contract and web3 methods.

Examples:
- `await web3.eth.getAccounts()`
 - Prints the accounts for you
- `currentStorage = await SimpleStorage.methods.get().call()`
 - Assigns the current value of the `SimpleStorage` contract to variable `currentStorage`
