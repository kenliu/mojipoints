class SlackUserFormatter
  def self.extract(formatted_string)
    /<@(U\w+)>/.match(formatted_string)[1]
  end

  def self.format(userid)
    "<@#{userid}>"
  end
end