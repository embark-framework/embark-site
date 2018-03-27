title: Contributing
---
## Development

We welcome you to join the development of Embark. This document will help you through the process.

### Before You Start

Please follow the coding style:

- Follow [Google JavaScript Style Guide](https://google.github.io/styleguide/jsguide.html).
- Use soft-tabs with a two space indent.
- Don't put commas first.

### Workflow

1. Fork [embark-framework/embark].
2. Clone the repository to your computer and install dependencies.

    {% code %}
    $ git clone https://github.com/<username>/embark.git
    $ cd embark
    $ npm install
    $ npm link
    {% endcode %}

3. Create a feature branch.

    {% code %}
    $ git checkout -b new_feature
    {% endcode %}

4. Start hacking.
5. Push the branch:

    {% code %}
    $ git push origin new_feature
    {% endcode %}

6. Create a pull request and describe the change.

### Notice

- Don't modify version number in `package.json`.
- Your pull request will only get merged when tests passed. Don't forget to run tests before submission.

    {% code %}
    $ npm run fulltest
    {% endcode %}

## Reporting Issues

When you encounter some problems when using Embark, you can find the solutions in [Troubleshooting](troubleshooting.html) or ask me on [GitHub](https://github.com/embark-framework/embark/issues). If you can't find the answer, please report it on GitHub.

1. Represent the problem in [debug mode](commands.html#Debug_mode).
2. Run `embark version` and check the version info.    
3. Post both debug message and version info on GitHub.

[embark-framework/embark]: https://github.com/embark-framework/embark

