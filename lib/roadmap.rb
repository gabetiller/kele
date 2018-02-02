module Roadmap

  def get_roadmap
    response = self.class.get(api_url("roadmaps/#{@roadmap_id}"), headers: { "authorization" => @auth_token})
    @roadmap = JSON.parse(response.body)
    # @checkpoint_id = response[sections][]
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_url("checkpoints/#{checkpoint_id}"), headers: { "authorization" => @auth_token})
    @checkpoint_id = JSON.parse(response.body)
  end

  def get_messages(page = nil)
    response = self.class.get(api_url("message_threads"), headers: { "authorization" => @auth_token})
    @messages = JSON.parse(response.body)
  end

  def create_message(recipient_id, subject, message, token = nil)

    response = self.class.post(api_url("messages"),
    body: { "sender": @email, "recipient_id": recipient_id, "subject": subject, "stripped-text": message, "token": token }, 
    headers: { "authorization" => @auth_token})
  end

end
