require 'rubygems'
require 'httparty'
require 'json'

class Kele
  include HTTParty
  format :json


  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @options = {query: {email: email, password: password}}
    response = self.class.post("/sessions", @options)
    @auth_token = response["auth_token"]
    if response && response["auth_token"]
      puts "This is your authorization token: #{@auth_token}"
    else
      puts "invalid user input"
    end
  end

end
