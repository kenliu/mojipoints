class SlackUserFormatter
  def self.unescape(formatted_string)
    match_data = /<@(U\w+)>/.match(formatted_string)
    match_data ? match_data[1] : formatted_string
  end

  def self.escaped_userid?(string)
    /\A<@U\w+>\z/.match(string) ? true : false
  end

  def self.format(userid)
    "<@#{userid}>"
  end

  def self.valid_userid?(userid_string)
    /U\w+/.match(userid_string) ? true : false
  end
end