Rails.application.routes.draw do
 
 resources :users, except: [ :delete ]
 resources :sessions, only: [ :create ]

 get '/login', to: "sessions#new", as: :login
 get '/log_out', to: "sessions#log_out", as: :logout

 get "/pages/:page" => "pages#show", as: :page

 root 'pages#show', page: "home"
end
