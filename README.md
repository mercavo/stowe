# Stowe
## Installation

Gemfile
```ruby
gem 'stowe', git: "git@github.com:mercavo/stowe.git", branch: 'master'
```
In packege.json.
```sh
"scripts": {
    "build": "esbuild app/javascript/*.* --bundle --outdir=app/assets/builds",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"
}
```

terminal
```
yes | rails g stowe:setup && bundle &&  yes | rails g stowe:install
```

##### for use SIDEKIQ 
in config/routes.rb
```require 'sidekiq/web'
```