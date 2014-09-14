CharlesEllsworth::Application.routes.draw do
  devise_for :admins

  root 'home#index'

  get "home", to: "home#index"
  get "bio/index"
  get "contact/index"
  get "news/index"
  get "admin/mass_signup"
  get "home/update_latest"
  get 'mailing_list/signed_up'
  get 'media', to: 'media#index'
  get 'media/albums'
  get 'shows', to: 'shows#index'

  post "mailing_list/signup"
  post 'contact/contact'
  post "shows/add_show"
  post "shows/delete"
end
