rails new __APP__ --css boostrap
./bin/setup
### descomentar
gem "sassc-rails"

rails g stowe:setup
bundle
rails g stowe:install

in package.json
"scripts": {
    "build": "esbuild app/javascript/*.* --bundle --outdir=app/assets/builds",
    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss ./app/assets/builds/application.css --no-source-map --load-path=node_modules"
}


 - se usar sidekiq
require 'sidekiq/web'


