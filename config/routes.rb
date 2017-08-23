Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  mount Hyperloop::Engine => '/hyperloop'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'

  get '/profile', to: 'static_page#profile'
  get '/profile-edit', to: 'static_page#profile-edit'
  get '/profile-gallery', to: 'static_page#profile-gallery'
  get '/profile-settings', to: 'static_page#profile-settings'

  get '/home', to: 'static_page#home'

  get '/messenger', to: 'static_page#messenger'

  get '/hotline', to: 'static_page#hotline'

  get '/layout', to: 'static_page#layout'
end
