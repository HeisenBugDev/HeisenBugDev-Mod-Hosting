# Getting Started

Read this to get your dev environment setup.

## Begin

_If you are on Windows™, curl up into a ball and cry. Know that by trying to get this website setup on Windows™ you are hurting yourself and that is very bad. Install Linux and be happy._

- Install [rvm](http://rvm.io) to manage your rubies.
- Clone the repo.
- Open a terminal, cd to the folder, and run `bundle install --without production`
- install redis (on mac it's `brew install redis` assuming you have homebrew)
- Run `rake db:migrate` (you may have to do `rake db:create` first)


### Setup a GitHub app
- Go to your GitHub settings.
- Click on Applications.
- Add an application.
- Fill out the fields. Authorization callback URL should be the local URL of your app (localhost:PORT)

Example of it filled out:
![Example setup](http://i.imgur.com/GloFH69.png)

- Create a file called .env in the root folder of your HeisenBugDev clone. Add the GitHub app keys to it. Example:

```
GITHUB_KEY=***********************
GITHUB_SECRET=***************************************
```

Continue by choosing the path you want:

### No tests

- Open up 2 terminals
- Run `redis-server` (on mac) in one.
- Run `rails server` in the other.

The console will tell you which port to connect on.

### With tests

- Open 2 terminals
- Run `guard` in one
- Run `zeus start` in the other

The console will tell you which port to connect on.

## Problems?

Create a ticket!