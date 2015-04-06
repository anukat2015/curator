Rails.application.routes.draw do
  root 'welcome#index'

  get '/download', to: 'welcome#download_csv'

  get "/#{ENV['SECRET_URI']}", to: 'reports#get_reports'
end
