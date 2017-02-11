module Commands
  class BaseCommand

    attr_reader :bot_user

    def initialize(bot_user:)
      @bot_user = bot_user
    end

    def direct_message(text, channel)
      DirectMessageResolver.filter(text, @bot_user, channel)
    end
  end
end