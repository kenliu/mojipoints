module Commands
  class BaseCommand

    attr_reader :bot_user, :teamid

    def initialize(teamid: nil, bot_user:)
      @bot_user = bot_user
      @teamid = teamid
    end

    def direct_message(text, channel)
      DirectMessageResolver.filter(text, @bot_user, channel)
    end
  end
end