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

  def get_messages(page_number = nil)
    if page_number == nil
      response = self.class.get(api_url("message_threads"), headers: { "authorization" => @auth_token })
    else
      response = self.class.get(api_url("message_threads?page=#{page_num}"), headers: { "authorization" => @auth_token })
    end
    response = self.class.get(api_url("message_threads"), headers: { "authorization" => @auth_token})
    @messages = JSON.parse(response.body)
  end

  def create_message(recipient_id, subject, message, token = nil)
    response = self.class.post(api_url("messages"),
    body: {
      "sender": @email,
      "recipient_id": recipient_id,
      "subject": subject,
      "stripped-text": message,
      "token": token
      },
      headers: { "authorization" => @auth_token})
      if response.success?
        puts "message sent"
      end  
  end

  def create_submission(checkpoint_id, assignment_branch,
    assignment_commit_link, comment, enrollment_id)
    response = self.class.post(api_url("checkpoint_submissions"),
    body: {
      "checkpoint_id": checkpoint_id,
      "assignment_branch": assignment_branch,
      "assignment_commit_link": assignment_commit_link,
      "comment": comment,
      "enrollment_id": enrollment_id
    },
    headers: { "authorization" => @auth_token})
    puts response
  end

end
