Rails.application.routes.draw do
  namespace :api do
    namespace :robot do
      post ':id/orders', to: 'orders#create'
    end
  end
end
