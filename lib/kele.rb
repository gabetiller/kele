require 'rubygems'
require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
  include HTTParty
  include Roadmap
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
    @mentor_id = response['current_enrollment']['mentor_id']
    @roadmap_id = response['current_enrollment']['roadmap_id']
    @user_data
  end

  def get_mentor_availability
    response = self.class.get(api_url("mentors/#{@mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentors_availability = JSON.parse(response.body)
  end



  private

  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end

end
