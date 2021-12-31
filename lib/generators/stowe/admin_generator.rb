module Stowe
  module Generators
    class AdminGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)

      def bundle
        inside Rails.root do
          run 'rails generate scaffold_controller User name avatar'
          run 'rails g model account_user account:references user:references role:integer is_main:boolean'
          run 'rails g migration add_role_to_user name avatar role:integer'
          # run 'rails db:migrate'
        end
      end

      def copy_app
        template "app/views/stowe/index.html.erb.tt"
        template "app/controllers/stowe_controller.rb.tt", File.join("app/controllers",  "stowe_controller.rb")
        template "app/models/account_user.rb"
      end
    end
  end
end

