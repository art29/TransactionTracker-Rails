Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/overrides/registrations',
      }
      resources :transactions do
        collection do
          get :month
          get :charts
          post :import
        end
      end
      resources :categories do
        collection do
          post '/:id/merge', to: 'categories#merge'
          post :reorder
        end
      end
    end
  end
end
