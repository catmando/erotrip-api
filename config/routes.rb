Rails.application.routes.draw do
  devise_for :users
  mount Hyperloop::Engine => '/hyperloop'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_page#home'

  get '/profile', to: 'static_page#profile'
  get '/profile-edit', to: 'static_page#profile-edit'
  get '/profile-gallery', to: 'static_page#profile-gallery'

  get '/layout', to: 'static_page#layout'
end
