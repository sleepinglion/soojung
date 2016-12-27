Soojung::Application.routes.draw do
  root 'home#index'
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, :controllers => { :sessions => "users/sessions",:registrations => "users/registrations" }, :path_names =>  {:sign_up=>'new',:sign_in => 'login', :sign_out => 'logout'} do    
    get '/users', :to => 'users/registrations#index'
    get '/login', :to => 'users/sessions#new'
  end
  
  resources :intro, :about, :gallery_categories, :galleries, :faq_categories,:faqs, :notices, :notices, :naver  
    
  resources :blogs do
    resources :blog_comments
  end   
  
  resources :questions do
    get 'password',:on=>:collection
    post 'password',:on=>:collection    
    resources :question_comments
  end
  
  resources :guest_books do
    resources :guest_book_comments do
      get 'password',:on=>:collection
      post 'password',:on=>:collection      
    end
  end
  
  get 'blogs/:blog_id/blog_comments/:id/password',:to=>'blog_comments#password'
  post 'blogs/:blog_id/blog_comments/:id/password',:to=>'blog_comments#password'
  
  get 'guest_books/:guest_book_id/guest_book_comments/:id/password',:to=>'guest_book_comments#password'
  post 'guest_books/:guest_book_id/guest_book_comments/:id/password',:to=>'guest_book_comments#password'  
  
  # admin 
  get '/admin', :to=>'admin/home#index'
  
  namespace :admin do
    resources :resources
    resources :intro,:gallery_categories, :galleries, :faq_categories,:faqs, :notices, :site, :intro, :contacts, :notices, :histories, :portfolios
    resources :questions do
      resources :question_comments
    end
    
    resources :blogs do
      resources :blog_comments
    end
    
    resources :questions do
      get 'password',:on=>:collection
      post 'password',:on=>:collection    
      resources :question_comments
    end
  
    resources :guest_books do
      resources :guest_book_comments do
        get 'password',:on=>:collection
        post 'password',:on=>:collection      
      end
    end    
  end  
end
