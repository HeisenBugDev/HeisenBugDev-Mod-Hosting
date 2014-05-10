# Getting Started

Read this to get your dev environment setup.

## Begin

_If you are on Windows™, curl up into a ball and cry. Know that by trying to get this website setup on Windows™ you are hurting yourself and that is very bad. Install Linux and be happy._

- Install [rvm](http://rvm.io) to manage your rubies.
- Clone the repo.
- Copy config/database.yml.example to config/database.yml
- Open a terminal, cd to the folder, and run `bundle install --without production`

### Install Redis

#### Linux
The next section requires that you have the ```redis``` package installed. If you are on a Linux distro, run the following commands:
```bash
wget http://download.redis.io/releases/redis-2.8.9.tar.gz
tar xzf redis-2.8.9.tar.gz
cd redis.2.8.9
make
```
Finally, run the command ```./redis-server``` (you must cd into the redis-2.8.9/src directory)

#### Mac
If you are on a Mac with homebrew, simply run ```brew install redis```.
Finally, run the command ```redis-server``


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

**Continue by choosing the path you want:**

### No tests

- Open up 2 terminals
- Run ```redis-server``` on macs, or ```./redis-server``` on Linux distros in one.
- Run ```rails server``` in the other.

The console will tell you which port to connect on.

### With tests

- Open 2 terminals
- Run `guard` in one
- Run `zeus start` in the other

The console will tell you which port to connect on.

### First user
Login to the app. Go to your terminal and run the command: `rake promote_admin` and `rake promote_owner` This makes the first user (you) admin and owner, giving you all rights.

## Problems?

Create a ticket!
