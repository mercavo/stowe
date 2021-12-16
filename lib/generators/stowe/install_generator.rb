module Stowe
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)

      def bundle
        inside Rails.root do
          run 'bundle'
          run 'rails generate devise:install'
          run 'rails generate devise user'
          run 'rails generate devise:views'
          run 'yarn add bootstrap'
          run 'yarn add css.gg'
          run 'yarn add stimulus'
          run 'yarn add stimulus-notification'
        end
      end

      def copy_config
        template ".env"
        template "config/initializers/devise.rb"
        template "config/initializers/assets.rb"
        template "config/locales/pt-BR.yml"

        template "config/locales/devise/devise.pt-BR.yml"
        template "config/locales/devise/devise.en.yml"
        template "config/locales/pagy/pagy.pt-BR.yml"
        template "config/locales/pagy/pagy.en.yml"
        template "config/locales/simple_form/simple_form.pt-BR.yml"
        template "config/locales/simple_form/simple_form.en.yml"
        
      end

      def copy_app
        template "app/controllers/homepage_controller.rb.tt", File.join("app/controllers",  "homepage_controller.rb")
        template "app/controllers/application_controller.rb.tt", File.join("app/controllers",  "application_controller.rb")
        template "app/views/homepage/index.html.erb.tt", File.join("app/views/homepage",  "index.html.erb")
        template "app/views/layouts/application.html.erb", File.join("app/views/layouts",  "application.html.erb")
        template "app/views/layouts/shared/_menu.html.erb.tt", File.join("app/views/layouts/shared",  "_menu.html.erb")
        template "app/views/layouts/shared/_flashes.html.erb.tt", File.join("app/views/layouts/shared",  "_flashes.html.erb")

        template "app/assets/stylesheets/application.bootstrap.scss.tt", File.join("app//assets/stylesheets",  "application.bootstrap.scss")
        template "app/assets/stylesheets/base.scss.tt", File.join("app/assets/stylesheets",  "base.scss")
        template "app/assets/stylesheets/variables.scss.tt", File.join("app/assets/stylesheets",  "variables.scss")
        template "app/javascript/controllers/index.js.tt", File.join("app/javascript/controllers",  "index.js")
      end

      def add_install_routes
        install_route  = "root 'homepage#index'"
        install_route << "\n"
        install_route << "# mount Sidekiq::Web => '/sidekiq'"
        route install_route
      end

      def add_application_config
        application"I18n.available_locales = [:en, :pt_BR]"
        application "config.i18n.default_locale = :'pt_BR'"
      end
    end
  end
end