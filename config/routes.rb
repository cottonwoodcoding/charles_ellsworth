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
  get 'admin/mailing_list_emails'
  get 'media/update_photos'
  get 'media/purchase_confirm'
  get 'media/purchase_error'
  get 'not_a_kickstarter', to: 'promotion#index'
  get 'contribute', to: 'promotion#contribute'

  post '/admin/download_link'
  post "mailing_list/signup"
  post 'contact/contact'
  post "shows/add_show"
  post "shows/delete"
  post "media/purchase"
  post "media/submit_purchase"
  post "/add_video", to: 'promotion#add_video'
  post '/update_contribution_text', to: 'promotion#update_contribution_text'
  post '/send_contribution', to: 'promotion#send_contribution'
end
