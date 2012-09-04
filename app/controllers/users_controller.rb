class UsersController < ApplicationController
  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to(@user)
    else
      @title = "Sign Up"
      @user.password = ""
      @user.password_confirmation = ""

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
