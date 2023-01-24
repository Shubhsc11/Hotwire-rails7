Rails.application.routes.draw do
  get 'home/index'
  get 'other/index'

  get '/home/turbo_frame_form' => 'home#turbo_frame_form', as: 'turbo_frame_form'
  post '/home/turbo_frame_submit' => 'home#turbo_frame_submit', as: 'turbo_frame_submit'

  post '/other/post_something' => 'other#post_something', as: 'post_something'
  
  root to: "home#index"
end
