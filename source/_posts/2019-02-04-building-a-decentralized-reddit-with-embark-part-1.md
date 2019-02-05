title: Building a decentralized Reddit with Embark - Part 1
summary: "Ever wanted to know what it needs to build a decentralized equivalent of a social platform like Reddit? In this three part tutorial series we're going to build one from scratch!"
categories:
  - tutorials
---

In this tutorial we want to get very practical and build a decentralized Reddit application from scratch using Embark. The goal is to get a better idea of not only what parts and components are involved when building such an application, but also which steps are required to get there, without getting too overwhelmed.

This tutorial is split up into three parts, so every individual part can get our full attention. The three parts are going to be:

- **Part 1** - Setting up the project and implementing a Smart Contract
- [**Part 2** - Testing the Smart Contract through EmbarkJS](/news/2019-02-11-building-a-decentralized-reddit-with-embark-part-2.html)
- **Part 3** - Building a simple front-end using React

We will link the other two parts once we've published them. We've also set up a [repository](https://github.com/embark-framework/dreddit-tutorial) with all code changes so you can follow along or review your own work.

Let's get right to it!

## Functionality Overview

Alright, let's start off with quickly talking about what exactly it is that we want to build. Obviously, Reddit is a pretty sophisticated platform so we won't be able to rebuild it completely. Instead, we'll be focusing on some key features that will also demonstrate very nicely how Embark can help building such an application.

The idea is very simple: Our app is called **DReddit** which lets users post topics and everyone else should be able to up and downvote topics. A user account is coupled to an Ethereum wallet account. Essentially every wallet account is a valid account for the application and users can authenticate using extensions like Metamask.

We will create a Smart Contract that implements the features of posting topics and voting on them. There's going to be a UI as well, built with React, but we'll do that in the third part of this series.

## Setting up the application

If you've read our guide on [Creating Applications](/docs/create_project.html) or our last tutorial on [Building Smart Contract only apps](/news/2019/01/22/building-smart-contract-only-dapps/), you know that Embark comes with a `new` command to scaffold an application. We're going to do exactly that, but first we need to make sure Embark is installed. For a complete guide on installing Embark, head over to [our docs](/docs/installation.html), otherwise, simply run the following command in your terminal of choice:

<pre><code>$ npm install -g embark@next</code></pre>

Notice that we're installing Embark's development version by using the `@next` tag. This will go away in the near future, however to get the newest features and performance improvements, this is the way to go for now.

Next, we'll create and set up our app using the `new` command:

<pre><code>$ embark new dreddit
$ cd dreddit
</code></pre>

Now is a good time to familiarize ourselves with the project structure. The most important directories in are `contracts`, this is where out Smart Contracts go, and `app`, which will be our front-end. Take your time to take a look and check out our [Application Structure](/docs/structure.html) guide for more detailed overview.

Also, to ensure and double-check that everything's working, we can run the application using Embark's `run` command:

<pre><code>$ embark run</code></pre>

If there are any issues in the "Available Services" section of the dashboard, go back to our [installation guide](/docs/installation.html) and make sure all tools are available on your machine.

## Creating the Smart Contract

Alright, next up we want to create the brain of our application, which is a Smart Contract written in [Solidity](https://solidity.readthedocs.io/en/v0.5.3/), that enables creating posts and votes. We're going to build it up step by step and afterwards we'll add some tests to ensure our code is actually working.

First thing we do is creating a file `DReddit.sol` inside `contracts` with a Smart Contract like this:

<pre class="solidity">
<button class="btn" data-clipboard-target="#cmd-1"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-1">pragma solidity ^0.5.3;

contract DReddit {

}</mark></code></pre>

Great! With that in place, let's introduce a couple of data structures for creating and storing topic posts. Let's say a post will have a creation date, a description and an address of the owner. There's a few more things we'll have to add, but let's do it one step at a time. Here's what a `Post` struct could look like:

<pre class="solidity">
<button class="btn" data-clipboard-target="#cmd-2"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-2">struct Post {
  uint creationDate;   
  bytes description;   
  address owner;
}</mark></code></pre>

We're also going to add an array to store all of our posts. Now that we have a `Post` struct, this is a simple as:

<pre class"solidity">
<button class="btn" data-clipboard-target="#cmd-3"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-3">Post [] public posts;</mark></code></pre>

### Creating posts

It's time to add our first method which will enable users to add new posts to the platform. For that, we'll create the method `createPost(bytes _description)` where `_description` are the bytes that represent the posts text.

<pre class="solidity">
<button class="btn" data-clipboard-target="#cmd-4"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-4">function createPost(bytes _description) public {
  uint postId = posts.length++;
  posts[postId] = Post({
    creationDate: block.timestamp,
    description: _description,
    owner: msg.sender
  });
}</mark></code></pre>

The first thing we do is creating an id for the post to be stored. We then use our `Post` struct to create a new post instance. Notice that we leverage the `postId` when storing the Post in our `posts` array. To set the owner, we take advantage of Solidity's global `msg` object which is available in every transaction. 

### Emitting events

As we're planning to build a front-end that reacts to posts being created, we need to emit an event so the front-end can subscribe to it accordingly. For that, we first introduce a new event type `NewPost` which will look something like this:


<pre class="solidity">
<button class="btn" data-clipboard-target="#cmd-5"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-5">event NewPost(
  uint indexed postId,
  address owner,
  bytes description
)</mark></code></pre>

Once that is done, all we have to do is emit `NewPost` inside `createPost()` with the required data:

<pre class="solidity"><code>function createPost(bytes _description) public {
  ...
  emit NewPost(postId, msg.sender, _description);
}</code></pre>

### Up and down voting posts

As mentioned earlier, Reddit allows for up and down voting topic posts. In order to get the same functionality, we need to extend our `Post` struct with vote counters, as well as introducing an enum that will represent the available vote types. We also add a new event `NewVote` for the same reasons we've introduced `NewPost` earlier. Once that is done, we can add a method that performs actual votes.

Let's start by adding an enum type calld `Ballot` that aggregates possible vote types:

<pre class="solidity"><code>enum Ballot { NONE, UPVOTE, DOWNVOTE }</code></pre>

To store votes on posts, we'll add an `upvotes` and `downvotes` counter to our `Post` struct accordingly. We'll also add a mapping that stores all the voters, so we can check and ensure that nobody tries to vote multiple times:

<pre class="solidity"><code>struct Post {
  ...
  uint upvotes;
  uint downvotes;
  mapping(address => Ballot) voters;
}</code></pre>

Here's the `NewPost` event which we'll use in a few moments:

<pre class="solidity">
<button class="btn" data-clipboard-target="#cmd-6"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-6">event NewVote(
  uint indexed postId,
  address owner,
  uint8 vote
);</mark></code></pre>

Last but not least, we have to update our `createPost()` function as the `Post` struct now needs `upvotes` and `downvotes`:


<pre class="solidity"><code>function createPost(bytes _description) public {
  ...
  posts[postId] = Post({
    ...
    upvotes: 0,
    downvotes: 0
  });
}</code></pre>

With these building blocks at hand, let's implement a `vote(uint postId, uint8 _vote)` method. `_vote` is going to be one of our defined `Ballot` types and is represented as uint going from 0 - 2. We'll use Solidity's `require()` statement to ensure we only vote on posts that actually exist, as well as nobody can actually vote multiple times on the same post. 

We then increment the up or down vote counter respectively, store the voter and emit a `NewVote` event:

<pre class="solidity">
<button class="btn" data-clipboard-target="#cmd-7"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-7">function vote(uint _postId, uint8 _vote) public {
  Post storage post = posts[_postId];

  require(post.creationDate != 0, "Post does not exist");
  require(post.voters[msg.sender] == Ballot.NONE, "You already voted on this post");

  Ballot ballot = Ballot(_vote);

  if (ballot == Ballot.UPVOTE) {
      post.upvotes++;
  } else {
      post.downvotes++;
  }

  post.voters[msg.sender] = ballot;
  emit NewVote(_postId, msg.sender, _vote);
}</mark></code></pre>

### Determine if users can vote

We probably want to add an indication to the UI that a user has already voted on a certain post. For that it'd be handy to have an API that actually tells us whether a user can vote on a post. We've already discussed earlier that users can't vote multiple times on the same post, so figuring out if a user can vote is pretty straight forward. Here's what a `canVote(uint _postId)` method could look like:

<pre class="solidity">
<button class="btn" data-clipboard-target="#cmd-8"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-8">function canVote(uint _postId) public view returns (bool) {
  if (_postId > posts.length - 1) return false;
  Post storage post = posts[_postId];
  return (post.voters[msg.sender] == Ballot.NONE);
}</mark></code></pre>

### Fetching votes

We also need a way to actually let users check what they've voted for, in case they did. For that we'll add a simple `getVote()` method that looks something like this:

<pre class="solidity">
<button class="btn" data-clipboard-target="#cmd-9"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-9">function getVote(uint _postId) public view returns (uint8) {
  Post storage post = posts[_postId];
  return uint8(post.voters[msg.sender]);
}</mark></code></pre>

And with that, our Smart Contract is pretty much done! Just to make sure that everything is compiling smoothly, we can execute `embark build --contracts` in case there's no existing Embark instance watching our work already.

Here's the complete Smart Contract code (you can also find it in [this repository](https://github.com/embark-framework/dreddit-tutorial):

<pre class="solidity">
<button class="btn" data-clipboard-target="#cmd-10"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
<code><mark id="cmd-10">pragma solidity ^0.5.0;

contract DReddit {

  enum Ballot { NONE, UPVOTE, DOWNVOTE }

  struct Post {
    uint creationDate;   
    bytes description;   
    address owner;
    uint upvotes;
    uint downvotes;
    mapping(address => Ballot) voters;
  }

  Post [] public posts;

  event NewPost(
    uint indexed postId,
    address owner,
    bytes description
  );

  event NewVote(
    uint indexed postId,
    address owner,
    uint8 vote
  );

  function createPost(bytes memory _description) public {
    uint postId = posts.length++;

    posts[postId] = Post({
      creationDate: block.timestamp,
      description: _description,
      owner: msg.sender,
      upvotes: 0,
      downvotes: 0
    });

    emit NewPost(postId, msg.sender, _description);
  }

  function vote(uint _postId, uint8 _vote) public {
    Post storage post = posts[_postId];

    require(post.creationDate != 0, "Post does not exist");
    require(post.voters[msg.sender] == Ballot.NONE, "You already voted on this post");

    Ballot ballot = Ballot(_vote);

    if (ballot == Ballot.UPVOTE) {
        post.upvotes++;
    } else {
        post.downvotes++;
    }

    post.voters[msg.sender] = ballot;
    emit NewVote(_postId, msg.sender, _vote);
  }

  function canVote(uint _postId) public view returns (bool) {
    if (_postId > posts.length - 1) return false;
    Post storage post = posts[_postId];
    return (post.voters[msg.sender] == Ballot.NONE);
  }

  function getVote(uint _postId) public view returns (uint8) {
    Post storage post = posts[_postId];
    return uint8(post.voters[msg.sender]);
  }
}
</mark></code></pre>

Wonderful! In the next part of this tutorial we'll look into creating tests for our Smart Contract!
