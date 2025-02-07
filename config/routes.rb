Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :people, only: [:index] do
        collection do
          post :import
        end
      end
    end
  end
end
