require 'rubygems'
require 'httparty'
require 'json'

class Kele
  include HTTParty
  format :json

  # base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @options = { query: { email: email, password: password } }
    response = self.class.post(api_url("sessions"), @options)
      raise "Invalid email or password" if response.code == 404
      @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(api_url("users/me"), headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  private

  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
