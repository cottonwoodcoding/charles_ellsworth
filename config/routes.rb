CharlesEllsworth::Application.routes.draw do
  devise_for :admins
  get "bio/index"
  get "contact/index"
  get "news/index"
  get "news/Index"
  root 'home#index'
end
