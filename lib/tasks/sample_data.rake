require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Call db:reset to blow out the existing data in the database.
    Rake::Task['db:reset'].invoke

    # Build two admin users
    admin = User.create!(:name => "Example User",
                         :email => "example@railstutorial.org",
                         :password => "foobar",
                         :password_confirmation => "foobar")

    admin.toggle!(:admin)

    vader = User.create!(:name => "Darth Vader",
                         :email => "bigdaddyv@deathstar.com",
                         :password => "foobar",
                         :password_confirmation => "foobar")

    vader.toggle!(:admin)

    # Build 99 other users, using Faker to generate random names. (I got 99 users, but my bitch ain't one...)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{ n + 1 }@railstutorial.org"
      password = "password"

      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    # Generate 50 posts for 6 users.  Use Faker to generate some content for the Microposts.
    50.times do
      User.all(:limit => 6).each do |user|
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end