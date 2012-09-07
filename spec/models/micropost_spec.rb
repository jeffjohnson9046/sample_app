require 'spec_helper'

describe Micropost do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = { :content => "some incredibly valuable content" }
  end

  it "should create a new Micropost given valid attributes" do
    @user.microposts.create!(@attr)
  end


  describe "users associations" do

    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have a 'user' attribute" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end

  end


  describe "validations" do

    it "should require a user id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require non-empty content" do
      @user.microposts.build(:content => " ").should_not be_valid
    end

    it "should not allow more than 140 characters for content" do
      @user.microposts.build(:content => "a" * 141).should_not be_valid
    end

  end

end
