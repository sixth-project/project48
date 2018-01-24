Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :users
  root 'static_pages#top'

  get 'static_pages/about', as: 'about'

  get 'static_pages/terms', as: 'terms'

  get 'static_pages/privacy', as: 'privacy'

  #ポストページのルート設定
  resources :posts, only: [:show, :new, :edit, :create, :update, :destroy]

  #Blogのルート設定
  resources :blogs

  #TinyMCEの写真Uploadのルート設定
  post '/tinymce_assets', to: 'blogs#upload_image'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
