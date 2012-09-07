class MicropostsController < ApplicationController
  include SessionsHelper

  before_filter :authenticate, :only => [:create, :destroy]

  # GET /microposts
  def index

  end

  # POST /microposts
  def create
    @micropost = current_user.microposts.build(params[:micropost])

    if @micropost.save
      flash[:success] = "Micropost created successfully."
      redirect_to(root_path)
    else
      render('pages/home')
    end
  end

  # DELETE /microposts/1
  def destroy
  end

end
