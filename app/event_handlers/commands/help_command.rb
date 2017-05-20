module Commands
  class HelpCommand < BaseCommand

    def match(message:, channel:)
      direct_message(message, channel) == 'help'
    end

    def response(params:)
      response = "Hi there, happy to help you out!\n" + help_string
      { text: response }
    end

    private

    def help_string
      bot_name = '@mojipoints'

"""
*Getting help*
\`#{bot_name} help\` : show this message

*How to upvote*
\`@user++\` or \`@user`:heavy_plus_sign: : upvote a user
\`@user++ for something\` : upvote a user with a reason
\`thing++` : upvote a thing
Add a reaction to keep voting up!

*How to downvote*
\`@user--\` or \`@user`:heavy_minus_sign: : downvote a user
\`@user-- for something\` : downvote a user with a reason
\`thing--` : downvote a thing
Add a reaction to keep voting down!

*Showing scores*
\`#{bot_name} top\` : show the leaderboard
\`#{bot_name} score @user\` : show the score for a user
"""
    end
  end
end