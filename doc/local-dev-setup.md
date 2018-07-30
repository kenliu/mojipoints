# Environment setup for local mojipoints development

This doc describes the external configuration needed for working with local dev and (private) staging environment.

## Slack test team

* team: ken-test-team.slack.com
* owner: ken@******.net
* admin: https://ken-test-team.slack.com/admin
* @mojipoints app points to staging app on Heroku

## Local dev environment setup

@mojipoints-dev app points to local dev (via ngrok tunnel)

### ngrok setup
1. ngrok admin: login with ken@******.net (use Google Auth login)
1. ngrok domain: mojipoints-dev.ngrok.io
1. install `ngrok` - run `brew bundle`
1. set up local dev access key using directions here https://dashboard.ngrok.com/auth

### local postgres setup


### local postgres DB load
* export dump file from heroku staging env DB
* load dump file into local postgres



## Staging environment

https://dashboard.heroku.com/apps/mojipoints-staging

## creating a local dev environment app on Slack

TK