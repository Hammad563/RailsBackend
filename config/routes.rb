Rails.application.routes.draw do

  resources :notes
    get '/userNotes', to: "notes#getUserNotes"

  resources :users, only: [:create, :destory, :index]
  post "/login", to: "users#login"
  get   "/authenticate", to: "users#auto_login"

end
