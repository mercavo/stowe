module Stowe
  module Generators
    class AccountGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)

      def bundle
        inside Rails.root do
          run 'rails g scaffold account name'
          run 'rails g migration CreateJoinTableAccountUser account user'
          run 'yarn add stimulus-timeago'
        end
      end 

      def copy_app
        #### model
        template "app/models/account.rb"
        template "app/views/accounts/create_account.html.erb"
        template "app/views/accounts/show.html.erb"
        template "app/views/accounts/_users_item.html.erb"
        template "app/views/accounts/_item.html.erb"


        template "app/controllers/accounts_controller.rb.tt", File.join("app/controllers",  "accounts_controller.rb")
      end
    end
  end
end

