Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :subscriptions, only: [:index, :show] do 
        member do
          patch :cancel
        end
      end
    end
  end
end