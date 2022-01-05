# Stowe
``` rails new APP -d=postgresql --css bootstrap ```

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
yes | rails g stowe:setup && bundle install && rails db:migrate &&  yes | rails g stowe:install && yes | rails g stowe:account && yes | rails g stowe:admin && yes | rails g stowe:pay && yes | rails g stowe:support
```

```
rails db:migrate
```



