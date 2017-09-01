Rails.application.routes.draw do

  #post 'newsletter/create', as: "newsletters"
  resources :newsletters
  resources :contacts
  get "downloader", to: 'newsletters#download'
 

  root to: 'frontend#index'
  get 'gallery/:category_permalink', to: 'frontend#gallery', as: "gallery"
  get 'index/:category_permalink', to: 'frontend#index', as: "conferencia"

  devise_for :users, skip: KepplerConfiguration.skip_module_devise

  resources :admin, only: :index

  scope :admin do
   
  	resources :users do 
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete '/destroy_multiple', action: :destroy_multiple, on: :collection, as: :destroy_multiple
    end  
  end


  #errors
  match '/403', to: 'errors#not_authorized', via: :all, as: :not_authorized
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  post '/send_mailer', to: 'frontend#send_mailer'

  #dashboard
  mount KepplerGaDashboard::Engine, :at => '/', as: 'dashboard'

  #blog
  mount KepplerBlog::Engine, :at => '/', as: 'blog'

  mount KepplerCatalogs::Engine, :at => '/', as: 'catalogs'


end
