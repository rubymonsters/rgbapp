# Rails Girls Berlin application

## How to set up

1. Clone the repo (`git clone <repo-url>`)
1. Cd into the directory
1. Run `bundle install`. This can fail for a number of reasons. See below for some
1. Run `rake db:create`. This will create the databases for development and test
1. Run `rails server`. This will start the application in development mode
1. Go to [`http://localhost:3000/`](http://localhost:3000/) in your browser. You should see a welcome screen saying *“Yay! You're on Rails”*

### Troubleshooting

#### Cloning the repo fails with some message about SSH keys

Use the `https` url instead. There is a link to get it under the GitHub *“clone or download”* menu.

#### Installing gem `pg` fails

##### Mac

Make sure Postgres is installed and set up. The easiest way is to use [http://postgresapp.com/](Postgres.app). Don't forget to setup the [CLI tools](http://postgresapp.com/documentation/cli-tools.html).

##### Linux

Make sure Postgres is installed and set up. In Debian/Ubuntu you'll need the `postgresql` and `libpq-dev` packages

##### Windows

TODO
