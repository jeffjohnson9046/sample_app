class UsersController < ApplicationController
  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      # handle the save...
    else
      @title = "Sign Up"
      render 'new'
    end
  end

  # GET /users/new
  def new
    @user = User.new
    @title = "Sign Up"
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
end
