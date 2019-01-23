title: How to create a Token Factory with Ethereum — Part 2
summary: "In this second part, we'll continue where we left off in part one, on building a token factory with Embark and focus on how to deploy new tokens."
categories:
  - Tutorial
alias:
  - "tutorials/token_factory_2.html"
---

In [part 1](/news/2018/09/27/how-to-create-a-token-factory-with-embark-part-1/) we deployed and interacted with a single Token. In this article we will continue by adapting the previous DApp to create a true factory so new tokens can be dynamically deployed on the application side.

A Token is typically a unit used to represent a medium of exchange for some service or utility. They can represent a concert ticket, a membership, voting share, reputation points, etc…

## Getting Started

For the second part of the tutorial, Embark 3.0 or higher is required.

If you are using an older version you can update with:

<pre>
<button class="btn" data-clipboard-target="#code-1"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code class="shell">$ <mark id="code-1">npm install -g embark@3</mark></code></pre>

Afterwards make sure that `embark version` returns 3.0 then restart embark with `embark run`

## Generalizing Token Interaction

We’ll start by generalizing the previous UI so we can input the address of a ERC20 Token and interact with it.

First, we’ll add a simple form to *app/index.html* to get address of the token we wish to interact with.

<pre>
<button class="btn" data-clipboard-target="#code-2"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code class="xml">&lt;html&gt;
  &lt;head&gt;
    &lt;title&gt;Embark&lt;/title&gt;
    &lt;link rel=&quot;stylesheet&quot; href=&quot;css/app.css&quot;&gt;
    &lt;script src=&quot;js/app.js&quot;&gt;&lt;/script&gt;
  &lt;/head&gt;
  &lt;body&gt;
    &lt;h3&gt;Welcome to Embark!&lt;/h3&gt;
    &lt;p&gt;See the &lt;a href=&quot;https://github.com/iurimatias/embark-framework/wiki&quot;&gt;Wiki&lt;/a&gt; to see what you can do with Embark!&lt;/p&gt;
<mark id="code-2" class="highlight-inline">
    &lt;div id=&quot;useToken&quot;&gt;
      &lt;h3&gt;Token Address&lt;/h3&gt;
      &lt;input placeholder=&quot;enter token address&quot; /&gt;
      &lt;button&gt;Use this Token&lt;/button&gt;
      &lt;div class=&quot;result&quot;&gt;&lt;/div&gt;
    &lt;/div&gt;
</mark>
    &lt;div id=&quot;queryBalance&quot;&gt;
      &lt;h3&gt;Query Balance&lt;/h3&gt;
      &lt;input placeholder=&quot;enter account address: e.g 0x123&quot; /&gt;
      &lt;button&gt;Query&lt;/button&gt;
      &lt;div class=&quot;result&quot;&gt;&lt;/div&gt;
    &lt;/div&gt;

    &lt;div id=&quot;transfer&quot;&gt;
      &lt;h3&gt;Transfer Tokens&lt;/h3&gt;
      &lt;input class=&quot;address&quot; placeholder=&quot;enter account address: e.g 0x123&quot; /&gt;
      &lt;input class=&quot;num&quot; placeholder=&quot;enter amount to transfer&quot; /&gt;
      &lt;button&gt;Transfer&lt;/button&gt;
      &lt;div class=&quot;result&quot;&gt;&lt;/div&gt;
    &lt;/div&gt;

  &lt;/body&gt;
&lt;/html&gt;<Paste>
</code></pre>

In *app/js/index.js* we’ll get the address given in the input, initialize a new contract object for that address and the Token ABI, and then assign it to a variable. We’ll also update the rest of code to use *currentToken* instead of *Token*. This way the existing code will work with the token we will be loading.

<pre>
<button class="btn" data-clipboard-target="#code-3"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code class="javascript">import EmbarkJS from 'Embark/EmbarkJS';
import $ from 'jquery';
import Token from 'Embark/contracts/Token';

let currentToken;

$(document).ready(function() {
<mark id="code-3" class="highlight-inline">
  $("#useToken button").click(function() {
    var address = $('#useToken input').val();
    currentToken = new EmbarkJS.Contract({
      abi: Token.options.jsonInterface,
      address: address
    });
  });
</mark>
  web3.eth.getAccounts(function(err, accounts) {
    $('#queryBalance input').val(accounts[0]);
  });

  $('#queryBalance button').click(function() {
    var address = $('#queryBalance input').val();
    currentToken.methods.balanceOf(address).call().then(function(balance) {
      $('#queryBalance .result').html(balance.toString());
    });
  });

  $('#transfer button').click(function() {
    var address = $('#transfer .address').val();
    var num = $('#transfer .num').val();
    currentToken.methods.transfer(address, num).send().then(function() {
      $('#transfer .result').html('Done!');
    });;
  });

});
</code></pre>

Now you can input the address of an existing token in chain, and interact with it. For instance, checking the embark dashboard.

![Console](/assets/images/token_factory_2/console_1.png)

I can see the address of the deployed token in my case is *0x0703da89fc6c3ff20b8787a23d3340b41258dba7*. Copy paste your equivalent address into the UI.

{% note help copying the address %}
*There are several ways to copy the address, in most systems pressing the ALT key while dragging with the mouse will enable text selection in the console, followed by CMD+C or right-click->copy.*
{% endnote %}

![Screenshot](/assets/images/token_factory_2/page_1.png)

After copying the address, click “Use this Token’, and let’s see the balance.

![Screenshot](/assets/images/token_factory_2/page_2.png)

It’s *980* as expected (*1000* was the initial supply as configured in *config/contracts.json* and *20* was transferred out in [part 1](/news/2018/09/27/how-to-create-a-token-factory-with-embark-part-1/)

## Deploy New Tokens on the fly

Now that we have an UI to interact with an existing Token given its address, we’ll add functionality to deploy tokens on the fly, each with their own initial supply.

First we’ll add a simple form to *app/index.html* to get the desired supply of the new token to deploy.

<pre>
<button class="btn" data-clipboard-target="#code-4"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code class="xml">&lt;html&gt;
  &lt;head&gt;
    &lt;title&gt;Embark&lt;/title&gt;
    &lt;link rel=&quot;stylesheet&quot; href=&quot;css/app.css&quot;&gt;
    &lt;script src=&quot;js/app.js&quot;&gt;&lt;/script&gt;
  &lt;/head&gt;
  &lt;body&gt;
    &lt;h3&gt;Welcome to Embark!&lt;/h3&gt;
    &lt;p&gt;See the &lt;a href=&quot;https://github.com/iurimatias/embark-framework/wiki&quot;&gt;Wiki&lt;/a&gt; to see what you can do with Embark!&lt;/p&gt;
<mark id="code-4" class="highlight-inline">
    &lt;div id=&quot;deployToken&quot;&gt;
      &lt;h3&gt;Deploy new Token&lt;/h3&gt;
      &lt;input placeholder=&quot;enter token supply&quot; /&gt;
      &lt;button&gt;Deploy&lt;/button&gt;
      &lt;div class=&quot;result&quot;&gt;&lt;/div&gt;
    &lt;/div&gt;
</mark>
    &lt;div id=&quot;useToken&quot;&gt;
      &lt;h3&gt;Token Address&lt;/h3&gt;
      &lt;input placeholder=&quot;enter token address&quot; /&gt;
      &lt;button&gt;Use this Token&lt;/button&gt;
      &lt;div class=&quot;result&quot;&gt;&lt;/div&gt;
    &lt;/div&gt;

    &lt;div id=&quot;queryBalance&quot;&gt;
      &lt;h3&gt;Query Balance&lt;/h3&gt;
      &lt;input placeholder=&quot;enter account address: e.g 0x123&quot; /&gt;
      &lt;button&gt;Query&lt;/button&gt;
      &lt;div class=&quot;result&quot;&gt;&lt;/div&gt;
    &lt;/div&gt;

    &lt;div id=&quot;transfer&quot;&gt;
      &lt;h3&gt;Transfer Tokens&lt;/h3&gt;
      &lt;input class=&quot;address&quot; placeholder=&quot;enter account address: e.g 0x123&quot; /&gt;
      &lt;input class=&quot;num&quot; placeholder=&quot;enter amount to transfer&quot; /&gt;
      &lt;button&gt;Transfer&lt;/button&gt;
      &lt;div class=&quot;result&quot;&gt;&lt;/div&gt;
    &lt;/div&gt;

  &lt;/body&gt;
&lt;/html&gt;
</code></pre>

Embark makes the contract objects available in the js side, each contract object will have a method called *deploy* that can deploy new instances of the contract. This method can take parameters for the contract, and it will return a promise containing a contract object of the deployed contract.

In *app/js/index.js* we’ll add the code to deploy new tokens client side using this functionality:

<pre>
<button class="btn" data-clipboard-target="#code-5"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code class="javascript">$(document).ready(function() {

  var currentToken;
<mark id="code-5" class="highlight-inline">
  $("#deployToken button").click(function() {
    var supply = $('#deployToken input').val();
    Token.deploy({arguments: [supply], data: Token.options.data}).send({gas: 400000}).then(function(deployedToken) {
      currentToken = deployedToken;
      $("#deployToken .result").append("<br>Token deployed with address: " + deployedToken.options.address);
    });
  });
</mark>
  $("#useToken button").click(function() {
    var address = $('#useToken input').val();
    currentToken = new EmbarkJS.Contract({
      abi: Token.options.jsonInterface,
      address: address
    });
  });

  web3.eth.getAccounts(function(err, accounts) {
    $('#queryBalance input').val(accounts[0]);
  });

  $('#queryBalance button').click(function() {
    var address = $('#queryBalance input').val();
    currentToken.methods.balanceOf(address).then(function(balance) {
      $('#queryBalance .result').html(balance.toString());
    });
  });

  $('#transfer button').click(function() {
    var address = $('#transfer .address').val();
    var num = $('#transfer .num').val();
    currentToken.methods.transfer(address, num).then(function() {
      $('#transfer .result').html('Done!');
    });;
  });

});
</code></pre>

When the Deploy button is clicked, we’ll get the supply entered and deploy a new Token with `Token.methods.deploy([supply])`. 
The resulting promise `.then(function(deployedToken) {})` will contain the contract object of newly deployed contract. We’ll assign this new token object to the current one *currentToken* and also inform the user of the address;

So let’s try this out! Entering the supply as 500 and clicking Deploy:

![Screenshot](/assets/images/token_factory_2/page_3.png)

Perfect! Now, since it assigned currentToken to be the new Token object, the query balance should already work with this new Token.

![Screenshot](/assets/images/token_factory_2/page_4.png)

It returns *500* as expected! Let’s deploy another token with a different supply and check Query balance again

![Screenshot](/assets/images/token_factory_2/page_5.png)

After deploying a new token with the supply at *200*, clicking query is also returning *200* as expected.

Let’s switch back to the first deployed token with “Use this Token” functionality to see if everything is working as expected.
Each time we are deploying a token in the client, the DApp is informing us “Token deployed with address: 0x…”, so let’s use this to copy paste the address of the first deployed contract into the Token Address field, then click “Use this Token” to switch back to that token.  

![Screenshot](/assets/images/token_factory_2/page_6.png)

Now checking the balance again:

![Screenshot](/assets/images/token_factory_2/page_7.png)

And it’s *500* as expected since that’s the initial supply defined for the first token deployed.

## Disabling the Token Deploy from Embarks side

Now that your DApp can deploy Tokens on the fly, It’s unnecessary for Embark to deploy the Token contract like it did in [part 1](/news/2018/09/27/how-to-create-a-token-factory-with-embark-part-1/), however you still need Embark to make the Token contract available on the client side.  To achieve this, go to config/contracts.js and set "deploy": false for that contract

<pre>
<button class="btn" data-clipboard-target="#code-6"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code class="javascript">module.exports = {
  "default": {
    // .....
    "gas": "auto",
    "contracts": {
      "Token": {
        <mark id="code-6" class="highlight-inline">"deploy": false,</mark>
        "args": [
          1000
        ]
      }
    }
    // .....
  }
}
</code></pre>

Embark will now no longer deploy that contract, in the dashboard you should see:

![Console](/assets/images/token_factory_2/console_2.png)

## Conclusion

In [part 1](/news/2018/09/27/how-to-create-a-token-factory-with-embark-part-1/) we deployed and interacted with single Token. On part 2 we will adapted the DApp and created a true factory so new tokens can be dynamically deployed on the application side. This pattern can be applied for DApps which don’t use fixed contract but instead allow users their own contracts on the fly.
