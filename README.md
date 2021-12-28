# Stowe
## Installation

Gemfile
```ruby
gem 'stowe', git: "git@github.com:mercavo/stowe.git", branch: 'master'
```
In packege.json.
```json
"scripts": {
    "build": "esbuild app/javascript/*.* --bundle --outdir=app/assets/builds",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"
}
```

terminal
```sh
yes | rails g stowe:setup && bundle &&  yes | rails g stowe:install && rails g scaffold account name && yes | rails g stowe:admin && yes | rails g stowe:pay && yes | rails g stowe:support
```

```
rails db:migrate
```



