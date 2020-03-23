# Rails Engine

### Description
Rails Engine is an API designed to expose fabricated sales data. It includes endpoints for records, relationships and business intelligence. There are six resources which can be accessed as well as business intelligence endpoints that were built with SQL and ActiveRecord queries.

### Installation
* Install Ruby 2.5.1
* Install Rails 5.2.4
* Install PostgreSQL
* Clone this repo to your local machine with: git clone git@github.com:mintona/rails_engine.git
* bundle install
* bundle update
* rails db:setup

Importing Data into your development database uses a rake task:
* `rails db:reset`
* `rake import`

This rails api app uses the following gems for testing:
   * rspec-rails
   * shoulda-matchers
   * factory_bot_rails

To run the test suite, simply run the command `rspec` from your terminal.
