Rails.application.routes.draw do
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree"
  mount Spree::Core::Engine, at: "/"
  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
end

Spree::Core::Engine.routes.draw do
  scope "(:amp)", constraints: { amp: /amp/ } do
    # Put here all routes that also have AMP variants
    root to: "home#index"

    resources :products, only: [:show]
    get '/orders/populate-get', to: 'orders#populate'

  end
end
