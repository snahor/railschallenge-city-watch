Rails.application.routes.draw do
  resources :emergencies, except: [:new, :edit], defaults: { format: 'json' }, param: :code
  resources :responders, except: [:new, :edit], defaults: { format: 'json' }, param: :name
  match '*path', to: 'application#not_found', via: :all
end
