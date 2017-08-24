Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  mount Hyperloop::Engine => '/hyperloop'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#home'
  root 'hyperloop#AppRouter'

  get '/static-profile', to: 'static_page#profile'
  get '/static-profile-edit', to: 'static_page#profile-edit'
  get '/static-profile-gallery', to: 'static_page#profile-gallery'
  get '/static-profile-settings', to: 'static_page#profile-settings'

  get '/static-home', to: 'static_page#home'

  get '/static-messenger', to: 'static_page#messenger'

  get '/static-hotline', to: 'static_page#hotline'

  get '/static-layout', to: 'static_page#layout'

  # always at the end!
  match '*all', to: 'hyperloop#AppRouter', via: [:get]
end
