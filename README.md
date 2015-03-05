Status
======

[![Build Status](https://travis-ci.org/snap-school/rsnap.png?branch=master)](https://travis-ci.org/snap-school/rsnap)
[![Dependency Status](https://gemnasium.com/snap-school/rsnap.png)](https://gemnasium.com/snap-school/rsnap)
[![Code Climate](https://codeclimate.com/github/snap-school/rsnap.png)](https://codeclimate.com/github/snap-school/rsnap)
[![Coverage Status](https://coveralls.io/repos/snap-school/rsnap/badge.png?branch=master)](https://coveralls.io/r/snap-school/rsnap?branch=master)
[Railsbp](http://railsbp.com/repositories/386-snap-school-rsnap)

Installation -- Linux only
============

* install [postgresql](http://www.postgresql.org/), 
	* Run "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - & apt-get update & apt-get upgrade"
	* Run "sudo apt-get install postgresql-9.3"
	* Run "sudo apt-get install libpq-dev" for dev libraries
	* Run postgresql ("sudo su - postgres")
	* Type "psql"
	* Type "CREATE ROLE 'username' SUPERUSER CREATEDB" where 'username' is your computer username
	* Type "\q" to quit
	* Type "exit" to quit

* install libraries for rmagick
	* run "sudo apt-get install libmagick++-dev"
	* run "sudo apt-get install libmagickwand-dev"

* copy `config/database.yml.example` to `config/database.yml` 
	* configure `config/database.yml`. You should set usernames to "rsnap" and passwords to your choosen password.
	

* install and configure [rvm](https://rvm.io/) with ruby
	* Make sure you already have curl (running "which curl" tells you if you have it. If you don't have it, run sudo apt-get install curl)
	* Run "\curl -sSL https://get.rvm.io | bash " to download RVM,
		* If it fails, use "gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
	* Add the line "source $HOME/.rvm/scripts/rvm" line to the end of ~/.bashrc
	* Run "rvm install 2.1.1" to install ruby 2.1.1
	* Run "rvm install rubygems latest" to install rubygems
	* Run "gem install rails -v '4.1' " to install rails 4.1
	
* Make sure you have qmake installed.
	* Run "sudo apt-get install libqt4-dev libqtwebkit-dev libqt5webkit5-dev"

* cd to the repository of rsnap

* run `bundle intall` and install all dependencies needed for the gems

* make sure you have bower installed 
	* run "sudo apt-get install npm"
	* run "sudo npm install bower -g"
	* run "sudo apt-get install nodejs-legacy"

* make sure you have a public key configured
	* run 'ls -al ~/.ssh"
	If there are no "id_rsa.pub" or files like that,
		* run "ssh-keygen -t rsa -c "your_email@here.com"
		* add the ssh public key to your github account

* run `rake bower:install`

* copy `.env.example` to `.env` and configure them if needed. 

* run `rake db:create db:migrate`
	* This will create the database.

* Check for the file "config/secrets.yml".
	It should at least contain "
			production:
  				secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>"

* run `rails s` to launch server
	* Create an account. This will be your admin account.

* run `rails c` and execute `User.all.first.add_role :admin` then 'exit'.
	* This will set the first user to admin. This should be the admin account if you did not created another account first.
