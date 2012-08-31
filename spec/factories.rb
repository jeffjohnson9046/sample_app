# The Factory Girl gem will allow us to simulate a User object with default values.  Basically, Factory Girl will
# create the mock objects for us, just like most other mocking frameworks.
Factory.define :user do |user|
  user.name                   "Darth Vader"
  user.email                  "bigdaddyv@deathstar.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end