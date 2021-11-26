Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post 'orders',      to: 'orders#create', defaults: { foramt: 'json' }
      patch 'orders/:id', to: 'orders#update', defaults: { foramt: 'json' }

      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    end
  end
end
