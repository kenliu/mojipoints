# README

## Building the application

TBD

## Create an app in Heroku

TBD

## Configure the app in Slack

1. Sign in to your Slack team and go to `https://api.slack.com/apps`
1. Click the green `Create an App` button
1. Set "Display Information"
    1. Set the "App name" (usually `mojipoints` but this is already taken)
    1. Set the "Short description" to `Give your coworkers points using emojis!`
    1. Upload the app icon from `icon.png` in the git repo
    1. Set "Background Color" to `#177300` or thereabouts
1. Click `Save Changes` (bottom right)
1. OAuth & Permissions -> Set `Redirect URLs` to `https://<Heroku app URL>/auth/finish` (click `Save URLs`)
1. Under `Basic Information` -> `App Credentials` you will find a "Client ID" and "Client Secret". Set `SLACK_CLIENT_ID` and `SLACK_API_SECRET` env variables in the Heroku app config using the generated values from Slack
1. Set the given `verification token` as `SLACK_VERIFICATION_TOKEN` env variable in the Heroku app config
1. Make sure the application is up and running on Heroku
1. Setup a bot user. Select "Bot Users"
   1. Click `Add a Bot User`.
   1. Set "Display name" to `mojipoints`
   1. Set "Default username" to `mojipoints`
   1. Enable `Always Show My Bot as Online`
   1. Click `Add Bot User`
1. Event Subscriptions
   1. Enable "Enable Events" toggle
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
1. Install the new app
   1. Go back to "Basic Information" and select "Install your app to your workspace" and click "Install App to Workspace"
   1. On the next screen, click "Authorize"
   1. Browse to `https://<Heroku app URL>/auth/begin` to install the app

## Credits

App Icon made by <a href="http://www.flaticon.com/authors/dave-gandy" title="Dave Gandy">Dave Gandy</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a>
