class UserController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
    @page_title = 'Create new account'
    if current_user
      flash[:notice] = 'Only one account can be created.'
      redirect_to :controller => 'about', :action => 'index'
    else
      # only when there are no accounts it allows to create a new one, unique in the system
      redirect_to :controller => 'user_session', :action => 'new' unless User.count == 0
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save # the new user has been logged in automatically
      flash[:notice] = "Account #{@user.name} was succesfully created. User logged in."
      redirect_to :action => 'show'
    else
      @page_title = 'Create new account'
      render :action => :new
    end
  end

  def edit
    @user = current_user
    @page_title = 'Edit account'
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account #{@user.name} was succesfully updated."
    else
      @page_title = 'Edit account'
      render :action => 'edit'
    end
  end

  def show
    @user = current_user
    @page_title = @user.name
  end
end
