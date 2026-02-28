class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :favorites]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User
    .search(params[:keyword])
    .with_attached_image
  end

  def show
    @user = User.with_attached_image
                .find(params[:id])

    @favorite_recipes = @user.favorite_recipes
                            .with_attached_image
                            .includes(user: { image_attachment: :blob })
    
    if @user == current_user 
      recipes = @user.recipes.with_attached_image.search(params[:keyword]) 
    else 
      recipes = @user.recipes.published.with_attached_image.search(params[:keyword])
    end 

    @recipes = case params[:sort]
             when "favorites"
               recipes.most_favorited
             when "old"
               recipes.oldest
             else
               recipes.latest
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

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to @user
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to @user
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.includes(image_attachment: :blob)
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.includes(image_attachment: :blob)
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
