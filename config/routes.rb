Rails.application.routes.draw do
  root 'welcome#index'
  get '/download', to: 'welcome#download_csv'
end
