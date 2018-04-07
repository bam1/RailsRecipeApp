Rails.application.routes.draw do
  
  #Goes to pages#home when hitting the root route
  root 'pages#home'
  
  get '/home', to: 'pages#home'

end
