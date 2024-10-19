class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(account_params)
      redirect_to account_path, notice: '設定が変更されました。'
    else
      render :edit
    end
  end

  private

  def account_params
    params.require(:user).permit(:email, :password, :name, :bio, :icon)
  end
end
