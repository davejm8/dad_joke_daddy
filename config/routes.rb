Rails.application.routes.draw do
  root 'users#new'
  post 'send_sms', to: 'users#send_sms'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
