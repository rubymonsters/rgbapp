# Rails Girls Berlin application

## About

This repo is the open source project for the `Rails Girls Berlin App` that aims to help the [Rails Girls Berlin orga team](http://railsgirlsberlin.de) to organize their events (`Beginners Workshop` and `Code and Cake`) by making the attendees, coaches and volunteers applications more manageable.

## How to set up

1. Clone the repo (`git clone <repo-url>`)
1. Change into the project directory (`cd rgbapp`)
1. Run `bundle install`. This can fail for a number of reasons. See below for some troubleshooting.
1. Run `(bundle exec) rake db:create`. This will create the databases for `development` and `test`.
1. Run `(bundle exec) rails server`. This will start the application in development mode.
1. Go to [`http://localhost:3000/`](http://localhost:3000/) in your browser. You should see a welcome screen saying *“Yay! You're on Rails”*

## Database

For the production database we use `Postgres`. Make sure Postgres is installed, configured and always running.

### Mac

The easiest way is to use [Postgres.app](http://postgresapp.com/). Don't forget to setup the [CLI tools](http://postgresapp.com/documentation/cli-tools.html).

### Linux

In Debian/Ubuntu you'll need the `postgresql` and `libpq-dev` packages.

### Windows

TODO

## Troubleshooting

**Cloning the repo fails with some message about SSH keys**

Use the `https` url instead. There is a link to get it under the GitHub *“clone or download”* menu.

**Installing gem `pg` fails**
