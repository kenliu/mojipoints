module Commands
  class WelcomeMessage < BaseCommand

    def match(message:, channel:)
      direct_message(message, channel) == 'help'
    end

    def response(params:)
      response = "happy to help!\n" + help_string
      { text: response }
    end

    private

    def help_string
      bot_name = '@mojipoints'
"""\`#{bot_name} help\` : show this message
\`@user++\` : upvote a user
\`@user--\` : downvote a user
\`@user++ for something\` : upvote a user with a reason
\`@user-- for something\` : downvote a user with a reason
\`#{bot_name} score @user\` : show the score for a user
\`#{bot_name} top\` : show the leaderboard
"""
    end
  end
end