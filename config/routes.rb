Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
  devise_for :users
  root 'main#index'
  get 'main/game' => 'main#game', :as => 'game'
  get 'main/result' => 'main#result', :as => 'result'
  get 'main/getcoordinate' => 'main#getcoordinate', :as => 'getcoordinate'
  get 'main/rank' => 'main#rank', :as => 'rank'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
