Status
======

[![Build Status](https://travis-ci.org/snap-school/rsnap.png?branch=master)](https://travis-ci.org/snap-school/rsnap)
[![Dependency Status](https://gemnasium.com/snap-school/rsnap.png)](https://gemnasium.com/snap-school/rsnap)
[![Code Climate](https://codeclimate.com/github/snap-school/rsnap.png)](https://codeclimate.com/github/snap-school/rsnap)
[![Coverage Status](https://coveralls.io/repos/snap-school/rsnap/badge.png?branch=master)](https://coveralls.io/r/snap-school/rsnap?branch=master)
[Railsbp](http://railsbp.com/repositories/386-snap-school-rsnap)

Installation
============

* install [postgresql](http://www.postgresql.org/), copy `config/database.yml.example` to `config/database.yml` and configure this file.

* install and configure [rvm](https://rvm.io/) with ruby

* run `bundle intall` and install all dependencies needed for the gems

* run `rake bower:install`

* copy `.env.example` to `.env` and configure them

* run `rake db:migrate`

* run `rails s` to create a user

* run `rails c` and execute `User.all.first.add_role :admin`
