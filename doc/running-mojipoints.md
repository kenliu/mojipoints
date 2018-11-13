# Guide to running mojipoints on Heroku

## Recommended mojipoints environment setup

Although mojipoints is generally environment agnostic, it was developed with Heroku in mind as a target deployment platform:
* Mojipoints running as a Heroku app
* Heroku Postgres (Hobby Dev)
 
Recommended Heroku add-ons:
* New Relic APM
* Papertrail
* Keen
* Rollbar

## General maintenance

Once running, mojipoints requires basically no ongoing maintenance. The only thing that might need to be done is to periodically deploy any new versions of the code and run any necessary DB migrations at that time.

## Deploying new releases

In general it is recommended to use Heroku git deployments (see docs here: https://devcenter.heroku.com/articles/git) for controlled production releases.

## DB migrations

Occasionally a mojipoints release will require a DB migration; even though Heroku can be set up to automatically deploy new updates to `master` from github, it does not automatically run the necessary migration command.

To run a migration, you'll need the Heroku CLI installed in order to run a DB migration on the target environment:

see https://devcenter.heroku.com/articles/heroku-cli for installation instructions.

### Running the DB migration

Run the DB migration using the built in rails migration command. This runs on a Heroku "one-off dyno" in the target environment.

`heroku run -a mojipoints-staging rails db:migrate`


# DB backups

Heroku Postgres Hobby Dev level databases do not support automatic backups, so it is recommended to periodically create a manual backup.

1. Open the mojipoints project in the Heroku web interface
2. Click the Heroku Postgres add-on from the Overview tab to open the DB admin web interface
3. Click on the "Durability" tab and click the "Create Manual Backup" button to initiate the creation of a manual backup
4. It should take a few minutes to create the backup snapshot and from here you can also download the backup file for safekeeping. If you don't download the backup file, Heroku will store the image as long as the database instance or project does not get deleted.
