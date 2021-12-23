module Stowe
  module Generators
    class AdminGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)

      def run
        inside Rails.root do
          run 'rails generate scaffold_controller User email password password_confirmation'
          run 'rails g controller stowe index'
          run 'rails db:migrate'
        end
      end
    end
  end
end

