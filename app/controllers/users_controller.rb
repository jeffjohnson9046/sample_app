class UsersController < ApplicationController
  include SessionsHelper
  before_filter :authenticate, :only => [:edit, :index, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to the Sample App!"

      redirect_to(@user)
    else
      @title = "Sign Up"
      @user.password = ""
      @user.password_confirmation = ""

      render(:new)
    end
  end

  # DELETE /users/1
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."

    redirect_to(users_path)
  end

  # GET /users/1/edit
  def edit
    #@user = User.find(params[:id])  <-- can be removed because we already have a handle on @user from the before_filter
    @title = "Edit User"
  end

  # GET /users
  def index
    @title = "All Users"
    @users = User.paginate(:page => params[:page]) # <-- the "paginate" method comes from the will_paginate gem.
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

  # PUT /users/1/edit
  def update
    #@user = User.find(params[:id])  <-- can be removed because we already have a handle on @user from the before_filter

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."

      redirect_to(@user)
    else
      @title = "Edit User"

      render(:edit)
    end
  end


  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
