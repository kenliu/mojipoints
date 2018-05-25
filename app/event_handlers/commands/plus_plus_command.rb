# Users familiar with older karma bots might use "++" to add points instead of emojis,
# This educates them on how to use emojis.
#
module Commands
  class PlusPlusCommand < BaseCommand
    def match(message:, channel:)
      message == '++'
    end

    def response(params:)
      response = """Hi there! Looks like you tried to give points to someone using `++`.
With @mojipoints, you use Slack emojis to give out points instead of the `++`.
(You still kick it off with `@somebody++` though.)

Here's a short video to show you how it works:
https://mojipoints-prod.herokuapp.com/mojipoints-demo-480.gif

If you want to learn more you can type `@mojipoints help`.
"""
      { text: response }
    end
  end
end