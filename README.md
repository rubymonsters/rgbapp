# Rails Girls Berlin application [![Build Status](https://travis-ci.org/rubymonsters/rgbapp.svg?branch=master)](https://travis-ci.org/rubymonsters/rgbapp)

## About

This repo is the open source project for the **Rails Girls Berlin App** that aims to help the [Rails Girls Berlin orga team](http://railsgirlsberlin.de) to organize their events by making the attendees, coaches and volunteers applications and/or participation more manageable.

## Technical Requirements

- Ruby '~> 2.3.x'
- Bundler
- Ruby on Rails '~> 5.1.0'
- PostgreSQL '~> 9.5.x'

## How to set up

1. Clone the repo (`git clone <repo-url>`)
1. Change into the project directory (`cd rgbapp`)
1. Run `bundle install`. This can fail for a number of reasons. See below for some troubleshooting.
1. Run `(bundle exec) rake db:create:all`. This will create the databases for `development` and `test` by default.
1. Run `(bundle exec) rails server`. This will start the application in development mode.
1. Go to [`http://localhost:3000/`](http://localhost:3000/) in your browser. You should see a welcome screen saying *“Yay! You're on Rails”*

## Database

### 1. Installation

For the production database we use `Postgres` - make sure it is installed, configured and always running.

#### Mac

The easiest way is to use [Postgres.app](http://postgresapp.com/). Don't forget to setup the [CLI tools](http://postgresapp.com/documentation/cli-tools.html).

#### Linux

In Debian/Ubuntu you'll need the `postgresql` and `libpq-dev` packages.

#### Windows

TODO

### 2. Migration

List all available rake tasks of this project:

```bash

# List all rake tasks
$ (bundle exec) rake -T

# Filter rake tasks related to the database
$ (bundle exec) rake -T | grep "db"
```

We already have a database structure file [here](https://github.com/rubymonsters/rgbapp/blob/master/db/schema.rb), just load it into your freshly created `development` database and migrate to be synced with the current project status:

```bash
# Loads a schema.rb file into the database
$ (bundle exec) rake db:schema:load

# Migrate the database
$ (bundle exec) rake db:migrate

# Display status of migrations
$ (bundle exec) rake db:migrate:status
```

Tip: You may take a look at the short cut `$ (bundle exec) rake db:setup` in the rake tasks list.

#### Important: Initial Data

Start up the server, go to `http://localhost:3000/sign_up` and sign up as a new user. Then log into the rails console and assign yourself as an admin in order to create a new event.

```bash
# Log into the console
$ (bundle exec) rails c

# List all users
>> users = User.all

# Find your user account
>> user = User.find_by(email: 'your_email@email.de')

# Assign yourself as an admin
>> user.admin = true

# Check if your last commmand worked
>> user.admin?
# => true

```

Since the database is initially empty, you may encounter an error similar to the one below.

**ERROR:**

```
ActiveRecord::RecordNotFound in ApplicationsController#new \
Couldn't find Event with 'id'=1
```

Execute following in the rails console:
```bash

# List all events
>> events = Event.all

# Event Load (0.7ms)  SELECT "events".* FROM "events"
# => #<ActiveRecord::Relation []>

# Create your first example event with a bang ("!") that validates your input immediately
>> event = Event.create!(name: "RGB Beginners WS 2017", place: "Travis", scheduled_at: "2017-10-31", application_start: "2017-10-02", application_end: "2017-10-20", confirmation_date: "2017-10-25")

# => #<Event id: 1, name: "RGB Beginners WS 2017", place: "Travis", scheduled_at: "2017-10-31 00:00:00", created_at: "2017-10-02 00:00:00", updated_at: "2017-10-02 00:00:00", application_start: "2017-10-02 00:00:00", application_end: "2017-10-20 00:00:00", confirmation_date: "2017-10-25 00:00:00">

# List all events
>> events = Event.all

# Event Load (0.4ms)  SELECT "events".* FROM "events"
# => #<ActiveRecord::Relation [#<Event id: 1, name: "RGB Beginners WS 2017", place: "Travis", scheduled_at: "2017-10-31 00:00:00", created_at: "2017-10-03 12:55:54", updated_at: "2017-10-03 12:55:54", application_start: "2017-10-02 00:00:00", application_end: "2017-10-20 00:00:00", confirmation_date: "2017-10-25 00:00:00">]>
```

Now start up the server with `rails s` again and go to:
http://localhost:3000/events/1/applications/new

The current production URL start page can be found here (this may change in the future):
http://radiant-bastion-50958.herokuapp.com/events/1/applications/new

**Attention: You would need access to the production database and heroku app for production deployment. Ask the maintainers of this repository for the credentials.**


## Good to know

**Shell prompt**

Dependent on your shell the prompt symbol may be different than `$`, e.g. `% (bundle exec) rake -T`.

**Specifying environment**

When not specifying any environment (e.g. `RAILS_ENV=development`), then you will execute all your commands in development mode by default.

**Server restart**

If you don't see any changes, e.g. after a migration, consider to restart the server and check again.

## Troubleshooting

**Cloning the repo fails with some message about SSH keys**

Use the `https` url instead. There is a link to get it under the GitHub *“clone or download”* menu.

**Installing gem `pg` fails**

TODO

**Running rake <option> fails**
You may see following error sometimes:

```
Gem::LoadError: You have already activated rb-readline 0.5.5, but your Gemfile requires rb-readline 0.5.4. Prepending `bundle exec` to your command may solve this.`.
```
If this is the case try `$ bundle update` and then run `$ bundle exec rake -T` instead of `rake -T`.
