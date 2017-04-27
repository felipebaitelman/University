Rails.application.routes.draw do

  devise_for :users, sign_out_via: [:get, :delete], :controllers => { registrations: 'registrations', sessions: 'sessions'}


  root 'pages#home'

  resources :users, only:[] do
    member do
      patch 'deauthorize'
      patch 'authorize'
    end
  end

  namespace :media do
    resources :images
    resources :videos
    resources :sounds do
      collection do
        post 'program_sound'
      end
      end
  end

  namespace :survey do
    resources :sleep_surveys,only:[:new, :create, :show, :destroy]
    resources :stress_surveys, only:[:new, :create, :show, :destroy]
    resources :stress2_surveys, only:[:new, :create, :show, :destroy]
  end

  resources :infographics do
    resources :image_sequences, only:[]
    collection do
      post 'order'
    end
  end

  resources :programs do
    resource :sound_sequences, only:[]
    collection do
      post 'order'
    end
  end

  get 'plans/display'
  get 'plans/start'
  post 'user_program' => 'programs#unlock'

  resources :logs, only:[:index, :show, :destroy] do
    post :create_conc, on: :collection
    post :create_des, on: :collection
    post :create_emp, on: :collection
    post :create_audio, on: :collection
    post :create_program, on: :collection

  end

  resource :games, only:[] do
    collection do
      get 'resp_cuadrada'
      get 'resp_guiada'
      get 'resp_alternada'
    end
  end

  resource :pages, only:[] do
    collection do
      get 'nature_display'
      get 'long_audio_display'
      get 'infographics_display'
      get 'home'
      get 'login'
    end
  end

  namespace :admin do
    get 'content/display'
    get 'statistics/display'
    get 'statistics/graphs'
    get 'management/index'
    get 'management/index_all'
    put 'management/deauthorize'

  end

  resources :booked_hours
  resources :events
  resources :days
  resources :event_types
  resources :faculties
  resources :event_dates

  get 'user_calendar/display'
  get 'user_hours/display'
  get 'admin_calendar/display'
  get 'admin_calendar_global/display'
  get 'admin_calendar_global/display'
  get 'event_date/json' => "event_dates#json"

  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      scope 'content' do
        get 'imagineries' => 'content#long_audio'
        get 'nature' => 'content#nature'
        get 'infographics' => 'content#infographics'
        get 'programs' => 'content#program'

      end
      scope 'logs' do
        post 'long_audio' => 'logs#long_audio'
        post 'nature' => 'logs#nature'
        post 'infographics' => 'logs#infographics'
      end
      scope 'programs' do
        put '/:id' => 'programs#update'
        get '/:id' => 'programs#current'
      end
      scope 'survey' do
        post 'GAD7' => 'survey#GAD7'
        post 'stress' => 'survey#stress'
        post 'sleep' => 'survey#sleep'
      end
      scope 'calendar' do
        get 'event_dates' => 'calendar#event_dates'
        post 'book' => 'calendar#book'
        post 'cancel_book' => 'calendar#cancel'
        get 'user_events' => 'calendar#user_events'
        get 'global_events' => 'calendar#global_events'
        post 'admin_cancel' => 'calendar#admin_cancel'
        get 'agenda_events' => 'calendar#agenda_events'
        post 'big_cancel' => 'calendar#big_cancel'
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
