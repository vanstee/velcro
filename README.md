# Velcro

![Test Status](https://secure.travis-ci.org/vanstee/velcro.png?branch=master)

Manage your dependencies with homebrew like you manage your gems with
bundler.

## Getting Started

1. Install the gem

   ```bash
   gem install velcro
   ```

2. Open up a project and install dependencies

   ```bash
   velcro install
   ```

   If this is the first time you are installing the project a `Brewfile`
   and `Brewfile.lock` will be generated.

3. Update a dependency to the most recent version

   ```bash
   velcro update redis
   ```

   This will update the version in the `Brewfile.lock`.

## Give Back

1. Fork it:

   https://help.github.com/articles/fork-a-repo

2. Create your feature branch:

   ```bash
   git checkout -b fixes_horrible_spelling_errors
   ```

3. Commit your changes:

   ```bash
   git commit -am 'Really? You spelled application as "applickachon"?'
   ```

4. Push the branch:

   ```bash
   git push origin fixes_horrible_spelling_errors
   ```

5. Create a pull request:

   https://help.github.com/articles/using-pull-requests
