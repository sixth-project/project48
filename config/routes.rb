Rails.application.routes.draw do
  devise_for :users
  resources :users
  root 'static_pages#top'

  get 'static_pages/about'

  get 'static_pages/terms'

  get 'static_pages/privacy'

  #ポストページのルート設定
  resources :posts, only: [:show, :new, :edit, :create, :update, :destroy]
  #ユーザーページのルート設定
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
