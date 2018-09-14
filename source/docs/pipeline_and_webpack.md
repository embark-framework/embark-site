title: Asset Pipeline & Webpack
---

### Specifying a mode

Embark has by default two modes for the building assets:

* `development` - Is faster to build, produces sourcemaps, but also outputs bigger js filesizes. Is the default mode of `embark run` and `embark console`
* `production` - Is slower to build but also outputs much smaller js filesizes. Is the default mode of `embark build` and `embark upload`

You can also specify a particular mode with `--pipeline`, for e.g

<pre><code class="shell">$ embark run --pipeline production</code></pre>

### Default webpack config

Embark has a internal default webpack config, this config allows you out of the box to:

* ES6 modules & imports
* Importing CSS, SCSS & Fonts in JS
* Support for React & JSX

### Ejecting & Customizing the Webpack config

If you want to override Embark's default webpack configuration, you can run:

<pre><code class="shell">$ embark eject-webpack</code></pre>

This command outputs the webpack file named `webpack.config.js` to the root directory of your dApp. You can then customize it to suit your specific needs.
