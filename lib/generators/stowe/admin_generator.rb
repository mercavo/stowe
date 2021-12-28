module Stowe
  module Generators
    class AdminGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)

      def bundle
        inside Rails.root do
          run 'rails generate scaffold_controller User name avatar'
          # run 'rails db:migrate'
        end
      end

      def copy_app
        template "app/views/stowe/index.html.erb.tt"
        template "app/controllers/stowe_controller.rb.tt", File.join("app/controllers",  "stowe_controller.rb")
      end
    end
  end
end

