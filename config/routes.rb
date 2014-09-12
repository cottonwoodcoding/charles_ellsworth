CharlesEllsworth::Application.routes.draw do
  devise_for :admins

  root 'home#index'

  get "bio/index"
  get "contact/index"
  get "news/index"
  get "admin/mass_signup"
  get "home/update_latest"
  get 'mailing_list/signed_up'
  get 'media', to: 'media#index'
  get 'media/albums'

  post "mailing_list/signup"

end
