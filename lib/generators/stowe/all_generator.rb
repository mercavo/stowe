module Stowe
  module Generators
    class AllGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)

      def bundle
        inside Rails.root do
          run 'yes | rails g stowe:setup'
          run 'yes | bundle install'
          run 'yes | rails g stowe:install'
          run 'yes | rails g stowe:account'
          run 'yes | rails g stowe:admin'
          run 'yes | rails g stowe:pay'
          # run 'yes | rails g stowe:support'
        end
      end   
    end
  end
end