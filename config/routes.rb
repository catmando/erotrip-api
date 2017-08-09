Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_page#home'
  get '/profile', to: 'static_page#profile'
  get '/profile-edit', to: 'static_page#profile-edit'
end
