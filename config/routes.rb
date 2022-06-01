Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "api/v1/health#index"

  namespace :api do
    api_version(
      path: { value: 'v1' },
      defaults: { format: :json },
      module: 'V1'
    ) do
      resources :health, only: %i[index] do
        get '/', to: 'health#index'
      end

      resources :auth, only: %i[] do
        collection do
          post :sign_in
          get :sign_out
          get :me
        end
      end
    end
  end
end
