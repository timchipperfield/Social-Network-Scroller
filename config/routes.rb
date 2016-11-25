Rails.application.routes.draw do

    namespace :api do
        namespace :v1 do
            resources :profiles, only: [:index, :show]
          end
    end
    root to: "api/v1/profiles#index"
end
