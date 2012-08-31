# The Factory Girl gem will allow us to simulate a User object with default values.  Basically, Factory Girl will
# create the mock objects for us, just like most other mocking frameworks.
FactoryGirl.define do
  factory :user do
    name "Darth Vader"
    email "bigdaddyv@deathstar.com"
    password "foobar"
    password_confirmation "foobar"
  end
end