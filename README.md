# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

# Ruby version: 2.6.8

# System dependencies: check Gemfile

# Configuration
$ execute: bundle install

# Database creation
$ bundle exec rake db:create

# Database initialization: Not need it

* How to run the test suite
# To run all specs
$ bundle exec rspec spec
# To run models' specs
$ bundle exec rspec spec/models
# to run integration tests
$ bundle exec rspec spec/request

# Services (job queues, cache servers, search engines, etc.)
# To run api server on port 3000
$ bundle exec rails s
# Endpoints 
## orders endpoint to create the order and its respective line_items, example: /api/v1/orders
* payload: { order: { line_items_attributes: [{ quantity: 2, amount: 10 }, { quantity: 1, amount: 20 }] }}
## orders/:id endpoint to update line_items belongs to an order, example: /api/v1/orders/1
* payload: { order: { id: 1,  line_items_attributes: [{ id: 1, quantity: 2, amount: 10 }, { id: 2, quantity: 1, amount: 20 }] } }

* ...
