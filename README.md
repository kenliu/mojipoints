# README

1. Go to api.slack.com
1. Create a new app
1. Set `SLACK_CLIENT_ID` and `SLACK_API_SECRET` env variables in the Heroku app config using the generated values from Slack
1. Set the given `verification token` as `SLACK_VERIFICATION_TOKEN` env variable in the Heroku app
1. Bot Users -> add a Bot user. set default username to `@mojipoints`
1. Enable `Always Show My Bot as Online`
1. Click `Add Bot User`
1. Event Subscriptions -> Enable Events
    * `message.channels`
    * `message.groups`
    * `message.im`
    * `message.mpim`
    * `reaction_added`
    * `reaction_removed`