class SlackMessagingService
  def self.im_channel(teamid, userid)
    # performance note: in the future we might want to
    # cache the user's DM channel on the SlackUser object
    # to avoid the overhead of hitting this API
    # for every single DM
    api = SlackApiService.create_slack_client(teamid)
    response = api.im_open(user: userid)
    response[:channel][:id]
  end
end