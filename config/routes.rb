Rails.application.routes.draw do
 
  root "home#index"
  
  match "/users" => "admin#create", :via => :post
  match "/users/:id" => "admin#update", :via => :patch

  get '/users/:id' => "admin#show"

  resources :users
  resources :admin

  match '/sign_up' => 'home#sign_up', :via => :get
  get '/sign_in' => 'home#sign_in' , :via => :get

  get 'home/index'
  post 'home/create'

  get 'home/destroy'
  match "/log" => "admin#log_out", :via => :get

  match "/sign_in_post" => "home#sign_in_post", :via => :post
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
