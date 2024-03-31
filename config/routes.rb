Rails.application.routes.draw do
  root "chatroom#index"
  get "login" => "sessions#new"
end
