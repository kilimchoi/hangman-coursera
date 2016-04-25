require 'net/http'

class HangmanGame
  attr_accessor :alphabets_used

  URL_BASE = "http://hangman.coursera.org/hangman/game"

  def initialize
    @alphabets_used = ('a'..'z').to_a
  end

  def start_the_game(email)
    url = URL_BASE 
    data = { email: email }
    make_post_req(url, data)
  end

  def guess(key, guess) 
    url = "%s/%s" % [URL_BASE, key]
    data = { guess: guess }
    make_post_req(url, data)
  end

  def make_post_req(url, data)
    uri = URI(url)
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    request = Net::HTTP::Post.new(uri, headers)
    request.body = data.to_json

    response = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(request) }

    JSON.parse(response.body)
  end
end
