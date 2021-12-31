module Stowe
  module Generators
    class PayGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates/install', __FILE__)

      def add_gem
        gem "stripe"
      end

      def bundle
        inside Rails.root do
          run 'rails g migration add_stripe_id_to_account stripe'
          run 'rails g scaffold plan name stripe_price_id amount status:integer'
          run 'rails g scaffold subscribe plan:references account:references name sign'
          run 'yarn add stimulus-stripe-elements'
        end
      end

      def copy_config
        template "config/initializers/stripe.rb"
      end

      def copy_app
        template "app/views/checkout/_form.html.erb.tt"
        template "app/views/checkout/show.html.erb.tt"
        template "app/views/checkout/thanks.html.erb.tt"

        template "app/javascript/controllers/stripe_controller.js.tt"

        template "app/views/plans/_form.html.erb.tt"

        template "app/controllers/checkout_controller.rb.tt", File.join("app/controllers",  "checkout_controller.rb")


        template "app/models/subscribe.rb.tt", File.join("app/models",  "subscribe.rb")
        template "app/models/plan.rb.tt", File.join("app/models",  "plan.rb")


        template "config/locales/plans/plans.pt-BR.yml"
        template "config/locales/checkout/checkout.pt-BR.yml"
        template "config/locales/checkout/checkout.en.yml"
      end

      def add_install_routes
        get 'checkout/:id', to: 'checkout#show'
        post 'checkout', to: 'checkout#create'
        get 'thanks/:id', to: 'checkout#thanks'
      end
    end
  end
end

