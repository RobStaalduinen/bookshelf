Rails.application.routes.draw do
 
 resources :users, except: [ :delete ]
end
