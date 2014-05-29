# encoding: UTF-8
class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]
  before_filter :require_no_user

  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Las instrucciones para recuperar su contraseña han sido enviadas a su email"
      redirect_to root_path
    else
      flash.now[:error] = "No existe ningún usuario con el email: #{params[:email]}"
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    flash[:notice] = "#{params[:password]}"
    @user.password = params[:password]
    # Only if your are using password confirmation
    @user.password_confirmation = params[:password]

    # Use @user.save_without_session_maintenance instead if you
    # don't want the user to be signed in automatically.
    if @user.update_attributes(params[:user])
      flash[:success] = "Su password ha sido actualizado"
      redirect_to :controller=>'user', :action => 'show', :id => @user.id
    else
      render :action => :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "Lo sentimos, no podemos recuperar su cuenta"
      redirect_to root_url
    end
  end
end