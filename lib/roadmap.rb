module Roadmap

  def get_roadmap
    response = self.class.get(api_url("roadmaps/#{@roadmap_id}"), headers: { "authorization" => @auth_token})
    @roadmap = JSON.parse(response.body)
    # @checkpoint_id = response[sections][]
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get(api_url("checkpoints/#{checkpoint_id}"), headers: { "authorization" => @auth_token})
    @roadmap = JSON.parse(response.body)
  end

end
