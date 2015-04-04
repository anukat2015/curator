Rails.application.routes.draw do
  root 'welcome#index'

  get '/download/:params' => 'reports#download_csv'

  get "/#{ENV['SECRET_URI']}", to: 'reports#get_reports'
end
