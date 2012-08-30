# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Some User", :email => "user@example.com" }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    user_without_name = User.new(@attr.merge(:name => ""))
    user_without_name.should_not be_valid
  end

  it "should require an e-mail address" do
    user_without_email = User.new(@attr.merge(:email => ""))
    user_without_email.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "foo" * 20
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid e-mail addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid e-mail addresses" do
    addresses = %w[user@foo,com THE_USER_at_foo.org first.last.jp.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate e-mail addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject duplicate e-mail addresses (case-insensitive)" do
    upper_case_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upper_case_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
end
