class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]
 
  def index
    @recipes = Recipe.includes(:user, :comments).search(params[:keyword])
  end

  def show
    @comments = @recipe.comments.order(created_at: :desc)
    @memo = Memo.find_or_initialize_by(recipe: @recipe, user: current_user)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def edit
  end


  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "更新に成功しました"
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to user_path(@recipe.user), notice: "レシピを削除しました"
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def correct_user
    if @recipe.user != current_user
      redirect_to recipes_path, alert: "不正なアクセスです"
    end
  end

end
