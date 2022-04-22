Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [] do
        resources :subscriptions, shallow: true, only: [:index, :create, :update]
      end
    end
  end
end
