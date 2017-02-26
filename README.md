# README

## Configure the app in Slack

1. Go to api.slack.com
1. Create a new app
1. Set `SLACK_CLIENT_ID` and `SLACK_API_SECRET` env variables in the Heroku app config using the generated values from Slack
1. Set the given `verification token` as `SLACK_VERIFICATION_TOKEN` env variable in the Heroku app
1. OAuth & Permissions -> Set `Redirect URL(s)` to `https://<Heroku app URL>/auth/finish` (click `Save Changes`)
1. Make sure the application is up and running
1. Bot Users -> add a Bot user. set default username to `@mojipoints`
1. Enable `Always Show My Bot as Online`
1. Click `Add Bot User`
1. Event Subscriptions -> Enable Events
1. Set the `Request URL` field to the event endpoint URL `https://<Heroku app URL>/events`. The server must be up and
 running so that Slack can verify the URL.
1. Add the following Bot Events:
    * `message.channels`
    * `message.groups`
    * `message.im`
    * `message.mpim`
    * `reaction_added`
    * `reaction_removed`
1. Don't forget to click `Save Changes`!
