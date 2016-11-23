Rails.application.routes.draw do

    constraints subdomain: "api" do
        scope module: 'api' do
          namespace :v1 do
            resources :profiles, only: :index
          end
        end
    end
end
