class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新に成功しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to recipes_path, notice: "ユーザーを削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :profile,
      :image
    )
  end

  def correct_user
    return if @user == current_user
    
    redirect_to users_path, alert: "不正なアクセスです。"
  end
end
