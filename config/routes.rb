Rails.application.routes.draw do
  root 'static_pages#top'

  get 'static_pages/about'

  get 'static_pages/terms'

  get 'static_pages/privacy'

  root 'statoc_pages#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
