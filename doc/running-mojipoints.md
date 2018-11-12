# Guide to maintaining mojipoints on Heroku

## Recommended mojipoints environment setup on Heroku

Heroku Postgres (Hobby Dev)


## General maintenance

Once running, mojipoints requires basically no ongoing maintenance. The only thing that might need to be done is to periodically manage any upgrades and run any necessary DB migrations.

## DB migrations

Occasionally a mojipoints release will require a DB migration.

You'll need the Heroku CLI installed in order to run a DB migration on the target environment:

see https://devcenter.heroku.com/articles/heroku-cli for installation instructions.

### Running the DB migration

`heroku run -a mojipoints-staging rails db:migrate`


# DB backups

Heroku Postgres Hobby Dev level databases do not support automatic backups, so it is recommended to periodically create a manual backup.

1. Open the mojipoints project in the Heroku web interface
2. Click the Heroku Postgres add-on from the Overview tab to open the DB admin web interface
3. Click on the "Durability" tab and click the "Create Manual Backup" button to initiate the creation of a manual backup
4. It should take a few minutes to create the backup snapshot and from here you can also download the backup file for safekeeping. If you don't download the backup file, Heroku will store the image as long as the database instance or project does not get deleted.