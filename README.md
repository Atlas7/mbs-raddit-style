# Introduction

A simple Rails CRUD app for user to share information.

Features:

- `devise` authentication (signup, signin, signout, etc.)
- create new entries (can be of medium "Picture", "Quote", etc.)
- each entry belongs to a category ("Mind", "Body", "Soul")
- votable entries and comments.
- nested comments (i.e. user may reply to previous comments).
- a bit of AJAX remote data transfer (e.g. as seen in the voting up and down).
- a bit of jQuery (as seen in the create new Entry form).
- a RESTful API (/api/v1) - with `devise_token_auth` gem for authentication via API.
- deployable to Heroku, with PostgreSQL database.
- parameterized URL (to filter on Category and Medium) - see the links at top navbar.
- a User profile listing out the entries that the user have published, voted up/down against.

## Running Locally

```sh
$ git clone https://github.com/Atlas7/mbs-raddit-style.git
$ cd mbs-raddit-style
$ bundle install
$ bundle exec rake db:setup
$ rails s
```

Your app should now be running on [localhost:3000](http://localhost:3000/).

## Deploying to Heroku

Make sure you have Ruby installed.  Also, install the [Heroku Toolbelt](https://toolbelt.heroku.com/).

Clean Installation (Note: this rebuild and seed DB)

```sh
$ heroku create
$ git push heroku master
$ heroku run rake db:setup
$ heroku open
```

## Heroku Ruby deployment Documentation

For more information about using Ruby on Heroku, see these Dev Center articles:

- [Ruby on Heroku](https://devcenter.heroku.com/categories/ruby)

