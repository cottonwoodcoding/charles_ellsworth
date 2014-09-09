CharlesEllsworth::Application.routes.draw do
  devise_for :admins

  root 'home#index'

  get "bio/index"
  get "contact/index"
  get "news/index"
  get "admin/mass_signup"

  post "admin/signup"

end
