A dead simple CI server which runs a desired command (usually to run your app tests). It can be configured as a GitHub push hook, so it'll pull the repo and run the tests automatically.

Technically supports more than just Rake tests, but didn't try.

This is not suitable for production, this is just some evening project I did.

Install
=======

NOT YET ON RUBYGEMS

Usage
=====

You'll need a config file, such as:

```ruby
Citadel::Settings.configure do
  command 'rake' # Command that Citadel will run for tests
  working_dir 'test_working/' # Working dir for storing the database and the repo
  branch 'master' # The branch you want to checkout
  github_url 'http://github.com/pablo-merino/rbedis' # The GitHub url of the repo
  username 'citadel' # Username for the Sinatra app
  password 'citadel' # Password for the Sinatra app

  # Hook that will be called when the testing ends
  after_testing do |results|
    puts results[:sha]
  end
end
```

Then just run `./bin/citadel <path of the config file>`. This will launch the Citadel core and a Sinatra web app, acessible on `0.0.0.0:8080`.

Author
======
[Pablo Merino](http://pmerino.me)<br/>
pablo@wearemocha.com<br/>
License: MIT<br/>
