class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :favorites]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User
    .with_attached_image
    .all
  end

  def show
    base_query = User.with_attached_image
                    .includes(recipes: { image_attachment: :blob })

    if current_user && current_user.id == params[:id].to_i
      @user = base_query
              .includes(
                favorite_recipes: [
                  { image_attachment: :blob },
                  { user: { image_attachment: :blob } }
                ]
              )
              .find(params[:id])
    else
      @user = base_query.find(params[:id])
    end
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

  def favorites
    @favorite_recipes = @user.favorite_recipes
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
