title: Working with the dashboard
---

![Dashboard](http://i.imgur.com/s4OQZpu.jpg)

The dashboard will tell you the state of your contracts, the environment you are using, and what Embark is doing at the moment.

**available services**

Available Services will display the services available to your dapp in green. If a service is down, then it will be displayed in red.

**logs and console**

There is a console at the bottom which can be used to interact with contracts or with Embark itself. Type ``help`` to see a list of available commands.  More commands will be added with each version of Embark.

{% note for without the dashboard %}
if you prefer to only see the logs, you can disable the dashboard with the nodashboard option ``embark run --nodashboard``
{% endnote %}

Note that if you update your code, it will automatically be re-deployed, contracts included. There is no need to restart embark, refreshing the page on the browser will do.
