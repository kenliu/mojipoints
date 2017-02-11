class DirectMessageResolver
  def self.filter(text, bot_user, channel)
    if /^<@(\w+)> (.*)$/ =~ text
      user = $1
      message = $2
      user == bot_user ? message : nil
    elsif channel.start_with?('D')
      text
    else
      nil
    end
  end
end