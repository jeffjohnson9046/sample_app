require 'spec_helper'

describe MicropostsController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post(:create)
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete(:destroy, :id => 1)
      response.should redirect_to(signin_path)
    end

  end


  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(FactoryGirl.create(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :content => "" }
      end

      it "should not create a new micropost" do
        lambda do
          post(:create, :micropost => @attr)
        end.should_not change(Microposts, :count)
      end

      it "should render the home page" do
        post(:create, @attr)
        response.should render_template('pages/home')
      end

    end

    describe "success" do

      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "should create a new micropost" do
        lambda do
          post(:create, :micropost => @attr)
        end.should change(Micropost, :count).by(1)
      end

      it "should have a flash message" do
        post(:create, :micropost => @attr)
        flash[:success] =~ /micropost created/i
      end

    end

  end

end