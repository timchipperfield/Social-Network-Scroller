Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    constraints: { subdomain: 'api' }, path: '/'  do
    end
  end

end
