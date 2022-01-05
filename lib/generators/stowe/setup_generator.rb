module Stowe
  module Generators
    class SetupGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)

      def add_gem
        gem "sidekiq"
        gem "dotenv-rails"
        gem 'devise', git: 'https://github.com/heartcombo/devise', branch: 'main'
        gem 'simple_form'
        gem 'pagy', '~> 5.6'
        gem 'groupdate'
      end

      def copy_app
        template ".env"
        template "config/database.yml"
        template "config/initializers/generators.rb"
        template "db/migrate/20220105191400_enable_uuid.rb"
      end
    end
  end
end

