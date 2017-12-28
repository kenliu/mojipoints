# README

## Building the application

TBD

## Create an app in Heroku

TBD

## Configure the app in Slack

1. Sign in to your Slack team and go to `https://api.slack.com/apps`
1. Click the green `Create an App` button
1. Set `SLACK_CLIENT_ID` and `SLACK_API_SECRET` env variables in the Heroku app config using the generated values from Slack
1. Upload the app icon from `icon.png`
1. Set the app name (usually `mojipoints` but this is already taken)
1. Set the "Short Description" to `Give your coworkers points using emojis!`
1. Click `Save Changes`
1. OAuth & Permissions -> Set `Redirect URL(s)` to `https://<Heroku app URL>/auth/finish` (click `Save Changes`)
1. Make sure the application is up and running
1. Bot Users -> add a Bot user. set default username to `@mojipoints`
1. Enable `Always Show My Bot as Online`
1. Click `Add Bot User` then `Save Changes`
1. Go back to Basic Information. Set the given `verification token` as `SLACK_VERIFICATION_TOKEN` env variable in the Heroku app
1. Event Subscriptions -> Enable Events
1. Set the `Request URL` field to the event endpoint URL `https://<Heroku app URL>/events`. The server must be up and
 running so that Slack can verify the URL. (It should display `Verified` successfully if everything is set up right on the server.)
1. Add the following Bot Events:
    * `message.channels`
    * `message.groups`
    * `message.im`
    * `message.mpim`
    * `reaction_added`
    * `reaction_removed`
1. Don't forget to click `Save Changes`!


## Credits

App Icon made by <a href="http://www.flaticon.com/authors/dave-gandy" title="Dave Gandy">Dave Gandy</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a>
