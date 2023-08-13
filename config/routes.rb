Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...
devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    root to: 'homes#top'
    resources :tags, only: [:index, :edit, :show, :create, :destroy, :update]
    resources :customers, only:[:index, :show, :edit, :update]

  end


# 顧客用

# URL /customers/sign_in ...
devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: :public do
    root to: 'homes#top'
    get '/attention' => 'homes#attention', as: 'attention'
    # 会員画面
    resources :customers, only: [:update, :show, :edit]
    # get   "customers/information/:id"      => "customers#show", as: 'customer_show'
    # get   "customers/information/:id/edit" => "customers#edit"
    # patch "customers/information"          => "customers#update"
    get   "customers/confirm_withdraw"     => "customers#confirm_withdraw"
    patch "customers/withdraw"             => "customers#withdraw"
    # 投稿
    resources :posts, only: [:index, :show, :edit, :create, :destroy, :update] do
      get :favorites, on: :collection
      resource :favorites, only: [:create, :destroy]
    end
    # 書籍検索
    get 'books/search', to: "books#search" do
      resource :posts , only: [:new]
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end