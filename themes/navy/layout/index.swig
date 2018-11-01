<div class="home-cover">
    <a href="https://github.com/embark-framework/embark"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://s3.amazonaws.com/github/ribbons/forkme_right_green_007200.png" alt="Fork me on GitHub"></a>
    <div class="header">
        <div class="header-left">
            <div class="logo-wrap">
                <a class="logo" href="/"></a>
                <a class="logo-sign" target="_blank" href="https://status.im">By Status</a>
            </div>

            <ul class="main-nav">
                <li><a href="/docs/">Docs</a></li>
                <li><a href="/tutorials/">Tutorials</a></li>
                <li><a href="/plugins/">Plugins</a></li>
                <li><a href="/templates/">Templates</a></li>
            </ul>
        </div>

        <div class="secondary-nav">
            <div id="search-input-wrap">
                <div id="search-input-icon">
                    <i class="fa fa-search"></i>
                </div>
                <input type="search" id="search-input" placeholder="Search...">
            </div>
            <span><a href="/news/" class="main-nav-link">Blog</a></span>
            <span><a href="/chat/" class="main-nav-link">Gitter</a></span>
            <span class="social-link social-link--github"><a href="https://github.com/embark-framework/embark"
                                                             target="_blank"></a></span>
        </div>
    </div>

    <div class="intro">
        <h1>Build Powerful DApps Easily</h1>
        <p>Embark is a fast, simple and powerful framework to help you develop and deploy Decentralized Applications</p>
        <div class="intro-buttons">
            <a class="button button--main" href="/docs/quick_start.html">Get Started</a>
            <a class="button button--secondary" href="/docs/">Documentation</a>
        </div>
    </div>

</div>

<div class="home-wrap">

    <div class="command-wrap">
        <div class="command">
            <span id="npm-current">npm install -g embark</span>
            <button class="btn" data-clipboard-target="#npm-current"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
        </div>
        <div class="command-description">
            Install Embark via <a href="https://github.com/creationix/nvm" target="_blank">NPM</a>
        </div>
        <div class="command-description">
            To get access to Embark 4 alpha:
        </div>
        <div class="command next">
            <span id="npm-next">npm install -g embark@next</span>
            <button class="btn" data-clipboard-target="#npm-next"><img class="clippy" width="13" src="/img/clippy.svg" alt="Copy to clipboard"></button>
        </div>
    </div>

    <div class="section-header section-header--main">
        <h2>Embark into the Ether</h2>
        <p>With Embark You Can Build On:</p>
    </div>

    <div class="features">
        <div class="features-wrap">

            <div class="features-item">
                <div class="features-item-inner">
                    <div class="features-item-top">
                        <h2>Ethereum Blockchains</h2>
                        <p>Automatically deploy contracts and access them with JS promises. Embark watches for changes,
                            and will redeploy contracts or DApps when updated.</p>
                        <p>Manage different chains and keep track of deployed contracts easily.
                            <!-- Deploy only when truly needed and handle complex systems of interdependent contracts with one simple file. --></p>
                    </div>
                    <div class="features-button-wrap">
                        <a class="button button--features button--light" href="/tutorials/token_factory_1.html">Tutorial
                            on Tokens</a>
                    </div>
                </div>
            </div>
            <div class="features-item">
                <div class="features-item-inner">
                    <div class="features-item-top">
                        <h2>Decentralized Storage</h2>
                        <p>Easily store and retrieve data in the DApp using IPFS. Upload and retrieve files easily
                            too.</p>
                        <p>Deploy your DApp to IPFS or Swarm.</p>
                    </div>
                    <div class="features-button-wrap">
                        <a class="button button--features button--light" href="/docs/storage_configuration.html" title="Decentralized storage tutorial">Tutorial
                            on IPFS</a>
                    </div>
                </div>
            </div>
            <div class="features-item">
                <div class="features-item-inner">
                    <div class="features-item-top">
                        <h2>Decentralized Communication (Whisper, Orbit)</h2>
                        <p>Easily send/receive messages through P2P channels.</p>
                        <p>Use Whisper or Orbit to fulfill your communication needs.</p>
                    </div>
                    <div class="features-button-wrap">
                        <a class="button button--features button--light" href="/docs/messages_configuration.html" title="Decentralized messaging tutorial">Tutorial
                            on messaging</a>
                    </div>
                </div>
            </div>
            <div class="features-item">
                <div class="features-item-inner">
                    <div class="features-item-top">
                        <h2>Web Technologies</h2>
                        <p>Integrate with any web technology, including React, Foundation, and Angular.</p>
                        <p>Use any build pipeline or tool, including grunt, gulp and webpack.</p>
                    </div>
                    <div class="features-button-wrap">
                        <a class="button button--features button--light" href="/docs/configuration.html">Learn
                            More</a>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="sections">
        <div class="inner-header">
            <h2>Journey Further With Our Unique Features</h2>
            <p>Embark is focussed on more than just contracts with out-of-the-box UI’s. We care about building powerful
                decentralized apps that will enable a more open and equitable web. Our tools now make it easy for more
                developers to build impactful products they can test and deploy simply and with confidence.</p>
        </div>

        <div class="section section--odd section--one">
            <div class="section__text">
                <h2>Interactive Dashboard</h2>
                <div class="text">
                    <p>Running Embark will reveal a dashboard right in your terminal that makes it easy to determine the
                        state of your contracts, the environment you are using, and what Embark is doing, all at a
                        glance.</p>
                    <p>Even this part of Embark is configurable. Don’t like the dashboard? Just use <strong>embark run
                            --nodashboard</strong></p>
                    <a class="section-link" href="/docs/quick_start.html">Learn More</a>
                </div>
            </div>
            <div class="section__image">
            </div>
        </div>
        <div class="section section--even section--two">
            <div class="section__text">
                <h2>Easy Configuration</h2>
                <div class="text">
                    <p>Embark lets you manage complex systems of contracts easily, pass dynamic references to other
                        contracts, deploy multiple instances, or access <strong>onDeploy</strong> or
                        <strong>afterDeploy</strong> lifecycle hooks from with the same <strong>contracts.json</strong>
                        file.</p>
                    <p>Easily specify dependencies, deployer accounts, static addresses, and anything else your system
                        needs to become a really powerful DApp.</p>
                    <p>Launch a blockchain of your own with one command. <strong>blockchain.json</strong> can be easily
                        set up to start your specified environment.</p>
                    <a class="section-link" href="/docs/contracts.html">Learn More</a>
                </div>
            </div>
            <div class="section__image">
            </div>
        </div>
        <div class="section section--even section--three">
            <div class="section__text">
                <h2>Plugin Ecosystem</h2>
                <div class="text">
                    <p>It’s all about extensibility. Use helpful pre-existing plugins for babel, webpack and a number of
                        other JS build tools.</p>
                    <p>Write your own plugins to suit your needs and share them with the whole community.</p>
                    <p>Want to code in LLL? Use the LLL plugin.
                        <!-- Want to support handlebars templates? Use the handlebars plugin. --> Want to develop DApps
                        for Status easily? There’s a plugin for that.
                        <!--Don’t like something and want to change it, or maybe there is some useful thing that you would like Embark to do? You can extend that too.--></p>
                    <p>The limit is only your imagination! Want a plugin that emails your boss every time your deploy to
                        production? Build it and we’ll share it.</p>
                    <a class="section-link" href="/plugins">See Plugins</a>
                </div>
            </div>
            <div class="section__image">
            </div>
        </div>
        <div class="section section--even section--four">
            <div class="section__text">
                <h2>More Than Just a Blockchain Framework</h2>
                <div class="text">
                    <p>In addition to the simple <strong>contracts.json</strong> file, Embark also comes with a <strong>storage.json</strong>
                        and a <strong>communication.json</strong> file that allows you to connect with IPFS for storage
                        and Whisper or Orbit for messaging. </p>
                    <p>To deploy a dapp to IPFS, all you need to do is run a local IPFS node and then run <strong>embark
                            upload ipfs</strong>. It really is that simple.</p>
                    <p>Swarm is also supported for deployment, just run a Swarm node and use <strong>embark upload
                            swarm</strong>.</p>
                    <!--p>Tests can readily be configured and use the well-known Mocha framework, though you can easily swap in any testing framework you prefer.</p -->
                    <a class="section-link" href="/docs/storage_configuration.html" title="Using storages in Embark">Storage</a> <a class="section-link"
                                                                                                    href="/docs/messages_configuration.html"
                                                                                                    title="Using message protocols in Embark"
                                                                                                   >Communication</a>
                </div>
            </div>
            <div class="section__image">
            </div>
        </div>
    </div>
</div>
