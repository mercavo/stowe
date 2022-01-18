module Stowe
  module Generators
    class SupportGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)


      def bundle
        inside Rails.root do
          run 'rails g scaffold support account:references subject status:integer'
          run 'rails action_text:install'
          run 'rails g model support_message support:references user:references body:rich_text'
          run 'yarn add stimulus-rails-nested-form'
        end
      end


      def copy_app
        template "app/views/supports/_form.html.erb.tt"
        template "app/views/supports/_message_form.html.erb.tt"
        template "app/views/supports/_head.html.erb.tt"
        template "app/views/supports/_message.html.erb"

        template "app/controllers/supports_controller.rb.tt", File.join("app/controllers",  "supports_controller.rb")


        template "app/models/support_message.rb.tt", File.join("app/models",  "support_message.rb")
        template "app/models/support.rb.tt", File.join("app/models",  "support.rb")
        
        template "config/locales/supports/supports.pt-BR.yml"
      end

      def add_install_routes
        get 'checkout/:id', to: 'checkout#show'
        post 'checkout', to: 'checkout#create'
        get 'thanks/:id', to: 'checkout#thanks'
      end
    end
  end
end

