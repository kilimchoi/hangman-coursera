class GamesController < ApplicationController
  def show
    @game = HangmanGame.new.start_the_game("user@example.com")

    session[:game] = { key: @game["game_key"], tries_left: @game["num_tries_left"] }

    render :show
  end

  def update
    tries_left = session[:game]["tries_left"].to_i
    guess = HangmanGame.new.guess(session[:game]["key"], game_params[:guess])

    render json: guess.except("game_key").merge(wrong: tries_left > guess["num_tries_left"].to_i)
  end

  private

  def game_params
    params.require(:game).permit(:guess)
  end
end
