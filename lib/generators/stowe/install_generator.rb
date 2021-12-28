module Stowe
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)

      def bundle
        inside Rails.root do
          run 'bundle'
          run 'rails generate devise:install'
          run 'rails generate devise user'
          run 'rails generate simple_form:install'
          run 'rails g migration CreateJoinTableAccountUser account user'
          run 'rails g migration add_role_to_user name avatar role:integer account_id:integer'
          # run 'rails g scaffold account name'
          run 'rails active_storage:install'
          # run 'rails db:migrate'
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
        template "config/initializers/pagy.rb"
        template "config/locales/pt-BR.yml"

        template "config/locales/devise/devise.pt-BR.yml"
        template "config/locales/devise/devise.en.yml"
        template "config/locales/pagy/pagy.pt-BR.yml"
        template "config/locales/pagy/pagy.en.yml"
        template "config/locales/simple_form/simple_form.pt-BR.yml"
        template "config/locales/simple_form/simple_form.en.yml"

        template "config/locales/accounts/accounts.en.yml"
        template "config/locales/accounts/accounts.pt-BR.yml"
        template "config/locales/users/users.en.yml"
        template "config/locales/users/users.pt-BR.yml"
        template "config/locales/homepage/homepage.en.yml"
        template "config/locales/homepage/homepage.pt-BR.yml"

        template "config/routes.rb"
      end

      def copy_scaffold
        template "lib/rails/generators/erb/scaffold/scaffold_generator.rb"
        template "lib/templates/active_record/model/model.rb"

        template "lib/templates/erb/scaffold/_actions.html.erb.tt"
        template "lib/templates/erb/scaffold/_form.html.erb.tt"
        template "lib/templates/erb/scaffold/_head.html.erb.tt"
        template "lib/templates/erb/scaffold/_item.html.erb.tt"
        template "lib/templates/erb/scaffold/_table.html.erb.tt"
        template "lib/templates/erb/scaffold/edit.html.erb.tt"
        template "lib/templates/erb/scaffold/new.html.erb.tt"
        template "lib/templates/erb/scaffold/index.html.erb.tt"
        template "lib/templates/erb/scaffold/show.html.erb.tt"

        template "lib/templates/rails/scaffold_controller/controller.rb.tt"
      end

      def copy_app
        #### model
        template "app/models/user.rb"
        template "app/models/account.rb"
        template "app/views/accounts/create_account.html.erb.tt"

        template "app/controllers/homepage_controller.rb.tt", File.join("app/controllers",  "homepage_controller.rb")
        template "app/controllers/authorized_controller.rb.tt", File.join("app/controllers",  "authorized_controller.rb")
        template "app/controllers/admin_controller.rb.tt", File.join("app/controllers",  "admin_controller.rb")
        template "app/controllers/util_controller.rb.tt", File.join("app/controllers",  "util_controller.rb")

        template "app/controllers/application_controller.rb.tt", File.join("app/controllers",  "application_controller.rb")
        template "app/views/homepage/index.html.erb.tt", File.join("app/views/homepage",  "index.html.erb")
        template "app/views/homepage/profile.html.erb.tt", File.join("app/views/homepage",  "profile.html.erb")
        template "app/views/layouts/application.html.erb", File.join("app/views/layouts",  "application.html.erb")
        template "app/views/layouts/auth.html.erb", File.join("app/views/layouts",  "auth.html.erb")
        template "app/views/layouts/admin.html.erb", File.join("app/views/layouts",  "admin.html.erb")
        template "app/views/layouts/shared/_menu.html.erb.tt", File.join("app/views/layouts/shared",  "_menu.html.erb")
        template "app/views/layouts/shared/_flashes.html.erb.tt", File.join("app/views/layouts/shared",  "_flashes.html.erb")
        template "app/views/layouts/shared/_items.html.erb.tt", File.join("app/views/layouts/shared",  "_items.html.erb")
        template "app/views/layouts/admin/_nav.html.erb.tt", File.join("app/views/layouts/admin",  "_nav.html.erb")

        template "app/views/devise/shared/_links.html.erb.tt", File.join("app/views/devise/shared",  "_links.html.erb")

        template "app/assets/stylesheets/application.bootstrap.scss.tt", File.join("app/assets/stylesheets",  "application.bootstrap.scss")
        

        template "app/assets/stylesheets/base.scss.tt", File.join("app/assets/stylesheets",  "base.scss")
        template "app/assets/stylesheets/variables.scss.tt", File.join("app/assets/stylesheets",  "variables.scss")
        template "app/javascript/controllers/index.js.tt", File.join("app/javascript/controllers",  "index.js")
        template "app/javascript/application.js.tt", File.join("app/javascript",  "application.js")

        template "app/helpers/application_helper.rb"

        template "app/views/devise/confirmations/new.html.erb"

        template "app/views/devise/mailer/confirmation_instructions.html.erb"
        template "app/views/devise/mailer/email_changed.html.erb"
        template "app/views/devise/mailer/password_change.html.erb"
        template "app/views/devise/mailer/reset_password_instructions.html.erb"
        template "app/views/devise/mailer/reset_password_instructions.html.erb"

        template "app/views/devise/passwords/edit.html.erb"
        template "app/views/devise/passwords/new.html.erb"

        template "app/views/devise/registrations/new.html.erb"
        template "app/views/devise/registrations/edit.html.erb"

        template "app/views/devise/sessions/new.html.erb"
        template "app/views/devise/shared/_error_messages.html.erb"

        template "app/views/devise/unlocks/new.html.erb"

        ##################SEEDS ###########################

        template "db/seeds.rb"

        ##################SEEDS ###########################

        template "public/404.html"
        template "public/422.html"
        template "public/500.html"

        template "public/imgs/favicon.ico"
        template "public/imgs/icon.png"
        template "public/imgs/logo.png"
        template "public/imgs/logo-x2.png"

        template "public/mail/chat.png"
        template "public/mail/mail.png"
        template "public/mail/whatsapp.png"
        
      end

      # def add_install_routes
      #   install_route  = "root 'homepage#index'"
      #   install_route << "\n"
      #   install_route << "# mount Sidekiq::Web => '/sidekiq'"
      #   install_route << "\n"
      #   install_route << "devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }"
      #   route install_route
      # end

      def add_application_config
        application"I18n.available_locales = [:en, :pt_BR]"
        application "config.i18n.default_locale = :'pt_BR'"
        application "config.x.mail_from = ENV['SES_EMAIL']"
        application "config.action_mailer.default_url_options = { host: ENV['DOMAIN'] }"
        application "config.action_mailer.smtp_settings = { 
                          address: ENV['SES_ADDRESS'],
                          user_name: ENV['SES_USERNAME'], 
                          password: ENV['SES_PASSWORD']
                        }"
        application "config.action_mailer.raise_delivery_errors = true"
      end
    end
  end

end