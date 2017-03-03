class SlackMessagingService

  def self.im_channel(teamid, userid)
    api = SlackApiService.create_slack_client(teamid)
    api.im_list['ims'].find { |im| im['user'] == userid }['id']
  end
end