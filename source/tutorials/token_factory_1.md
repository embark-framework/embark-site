title: How to create a Token Factory with Ethereum — Part 1
---

In this tutorial series we’ll create a Token Factory using Ethereum. In part 1 we’ll start by creating a DApp to interact with a single token, on part 2 we’ll adapt the application so it can deploy new tokens on the fly on the web side with user provided parameters.

A Token is typically a unit used to represent a medium of exchange for some service or utility. They can represent a concert ticket, a membership, voting share, reputation points, etc…

**TODO: update the tutorial to 3.0**
note: This tutorial is meant for embark 2.5.2 (not 2.6.0 and above)

## Getting Started

First of all, make sure you have [Go-Ethereum](https://geth.ethereum.org/) and Embark installed.

```Bash
npm -g install embark@2.5.2
```

Now, let’s create a new dapp

```Bash
embark new TokenFactory
```

This will create a directory called TokenFactory, cd to it and run:

```Bash
embark blockchain
```

In another console, in the same directory, run:

```Bash
embark run
```

You should see something like this:

![Dashboard Code](token_factory_1/dashboard.png)

{% note warn if you can't use the dashboard %}
In some system setups there are difficulties using the dashboard, if that's your case or if you prefer to simply see the logs you can run embark with the dashboard disabled `embark run --nodashboard `
{% endnote %}

Now open your browser at http://localhost:8000 , start your favourite editor and let’s get started!

## Adding the Token Contract

We’ll add a typical ERC20 token contract to app/contracts/token.sol

**TODO: add contract code**

*warning: this contract is for educational purposes only, do not use it in production unless you know what you are doing*

Embark will automatically detect the new file and deploy the contract. However we quickly notice a problem, in Embark’s console type:

```Javascript
Token._supply().toNumber()
```

![Console](token_factory_1/console_1.png)

The supply is zero, that’s because the contract constructor takes a *initial_balance* parameter which we haven’t specified:

```Javascript
function Token( uint initial_balance ) {
    _balances[msg.sender] = initial_balance;
    _supply = initial_balance;
}
```

Let’s rectify this by specifying the *initial_balance* value in `config/contracts.json`

```Json
{
  "default": {
    "gas": "auto",
    "contracts": {
      "Token": {
        "args": [
          1000
        ]
      }
    }
  }
}
```

Embark will detect the change and redeploy the contract with the new parameters, afterwards the token supply is 1000 as expected:

![Console](token_factory_1/console_2.png)

## Creating the UI

For the sake of brevity, we wouldn’t implement every single functionality in the contract. However, we’ll implement two important features: Checking balance of an address and Transferring Tokens from one address to another.

## Checking address balance

To input the address to query, we’ll edit *app/index.html* and add a simple form.

```Markdown
<html>
  <head>
    <title>Embark</title>
    <link rel="stylesheet" href="css/app.css">
    <script src="js/app.js"></script>
  </head>
  <body>

    <div id="queryBalance">
      <h3>Query Balance</h3>
      <input placeholder="enter account address: e.g 0x123" />
      <button>Query</button>
      <div class="result"></div>
    </div>

  </body>
</html>
```

**Adding jQuery**
To simplify the code a bit in this tutorial, we’ll add the jQuery library to our DApp. Download jQuery from [here](https://code.jquery.com/jquery-3.1.1.min.js) and save it in your dapp *app/js/* folder.

Alternatively:

```Bash
cd app/js/ && wget https://code.jquery.com/jquery-3.1.1.min.js
```

*note: To use libraries such as react, give a look at a plugin such as [embark-babel](https://github.com/iurimatias/embark-babel)*

**Setting the default address**

Let’s add to the input field field our own address as the default text so we can easily query our own balance. create the file *app/js/token.js* and add:

```Javascript
$(document).ready(function() {
  web3.eth.getAccounts(function(err, accounts) {
    $('#queryBalance input').val(accounts[0]);
  });
});
```

This will get the address of the first account and set it as the default text in the input form.

**Querying Balance**

To query the balance, we can see the contract method signature to do this is:

```Javascript
function balanceOf( address who ) constant returns (uint value) {
  return _balances[who];
}
```

This method will be available in the JS code automatically as a promise, like:

```Javascript
Token.balanceOf(address).then(function(balance) { });
```

So we can simply add a click event to the button, get the address, query the balance and set the result.

```Javascript
$(document).ready(function() {

  web3.eth.getAccounts(function(err, accounts) {
    $('#queryBalance input').val(accounts[0]);
  });

  $('#queryBalance button').click(function() {
    var address = $('#queryBalance input').val();
    Token.balanceOf(address).then(function(balance) {
      $('#queryBalance .result').html(balance.toString());
    });
  });

});
```

*note: since the balance variable is a Big Integer, to read it it’s necessary to apply either .toNumber() or .toString()*

![Screenshot](token_factory_1/page_1.png)

Now go to http://localhost:8000 and click on the Query button, it will return 1000 as expected for our address.

## Transferring Tokens

Now let’s implement transferring tokens!

Now checking the contract, this is the method for transferring tokens:

```Javascript
function transfer( address to, uint value) returns (bool ok)
```

The method will take two parameters, an address and a value. Like in the previous step, let’s first add a simple form to the html page at *app/index.html*:

```Plain
<html>
  <head>
    <title>Embark</title>
    <link rel="stylesheet" href="css/app.css">
    <script src="js/app.js"></script>
  </head>
  <body>
    <h3>Welcome to Embark!</h3>
    <p>See the <a href="https://github.com/iurimatias/embark-framework/wiki">Wiki</a> to see what you can do with Embark!</p>

    <div id="queryBalance">
      <h3>Query Balance</h3>
      <input placeholder="enter account address: e.g 0x123" />
      <button>Query</button>
      <div class="result"></div>
    </div>

    <div id="transfer">
      <h3>Transfer Tokens</h3>
      <input class="address" placeholder="enter account address: e.g 0x123" />
      <input class="num" placeholder="enter amount to transfer" />
      <button>Transfer</button>
      <div class="result"></div>
    </div>

  </body>
</html>
```

Then we will add the code to take the address and number of tokens from the inputs and call the contracts transfer method to *app/js/token.js*:

```Javascript
$(document).ready(function() {

  web3.eth.getAccounts(function(err, accounts) {
    $('#queryBalance input').val(accounts[0]);
  });

  $('#queryBalance button').click(function() {
    var address = $('#queryBalance input').val();

    Token.balanceOf(address).then(function(balance) {
      $('#queryBalance .result').html(balance.toString());
    });
  });

  $('#transfer button').click(function() {
    var address = $('#transfer .address').val();
    var num = $('#transfer .num').val();

    Token.transfer(address, num).then(function() {
      $('#transfer .result').html('Done!');
    });;
  });

});
```

Let’s go to the UI and transfer 20 tokens to a random address, after clicking Transfer you should see the text ‘Done!’ when the transfer takes effect.

![Screenshot](token_factory_1/page_2.png)

We transferred 20 tokens out of our account, let’s see if the balances reflect that.

![Screenshot](token_factory_1/page_3.png)

![Screenshot](token_factory_1/page_4.png)

## On to Part 2

In this tutorial we deployed and interacted with single Token. On [part 2](/tutorials/token_factory_2.html) we will adapt this DApp and create a true factory so new tokens can be dynamically deployed on the application side.

