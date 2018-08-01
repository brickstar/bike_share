class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:alert] = "Invalid account credentials. Note: Password must contain at least 8 characters."
      render :new
    end
  end

  def edit
    render file: '/public/404' unless current_user.id.to_s == params[:id]
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = 'Account details updated.'
      if current_admin?
        redirect_to admin_dashboard_path
      else
        redirect_to dashboard_path
      end
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :street, :city, :state, :zip_code, :email, :password)
  end
end
