Rails.application.routes.draw do
  root to: "games#show"

  resource :game, only: %i(show update)
end
