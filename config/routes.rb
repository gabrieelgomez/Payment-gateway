Rails.application.routes.draw do

  #get 'checkouts/checkout'

  #post 'newsletter/create', as: "newsletters"
  resources :newsletters
  resources :contacts
  get "downloader", to: 'newsletters#download'

  #resources :checkouts,  only: [:new, :create, :show]

  root to: 'frontend#index'
  get 'gallery/:category_permalink', to: 'frontend#gallery', as: "gallery"
  get 'index/:category_permalink', to: 'frontend#index', as: "conferencia"

  get 'cursos', to: 'payments#categories', as: "courses_front"
  get 'cursos/:id', to: 'payments#courses_categories', as: "app_courses"
  post '/', to: 'payments#create', as: "app_create_subscriber"
  post '/checkout', to: 'payments#checkout', as: "checkout"
  get '/mercadopago/:id', to: 'payments#checkout_mercadopago', as: "checkout_mercadopago"
  get '/checkout/:id', to: 'payments#checkout_id', as: "checkout_id"
  get 'payments/:id/:method', to:'payments#payments', as:"payments"

  #post "/subscribers/:id" => "subscriber#show"
  post "/hook", to: "subscriber#hook", as: "hook"

  devise_for :users, skip: KepplerConfiguration.skip_module_devise

  resources :admin, only: :index

  scope :admin do

  	resources :users do
      get '(page/:page)', action: :index, on: :collection, as: ''
      delete '/destroy_multiple', action: :destroy_multiple, on: :collection, as: :destroy_multiple
    end
  end

  scope :admin do
    resources :categories do
      get '(page/:page)', action: :index, on: :collection, as: ''
      get '/clone', action: 'clone'
      delete(
        action: :destroy_multiple,
        on: :collection,
        as: :destroy_multiple
      )
        resources :courses do
          get '(page/:page)', action: :index, on: :collection, as: ''
          get '/clone', action: 'clone'
          delete(
            action: :destroy_multiple,
            on: :collection,
            as: :destroy_multiple
          )
            resources :subscribers do
              get '(page/:page)', action: :index, on: :collection, as: ''
              get '/clone', action: 'clone'
              delete(
                action: :destroy_multiple,
                on: :collection,
                as: :destroy_multiple
              )
            end
        end
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
