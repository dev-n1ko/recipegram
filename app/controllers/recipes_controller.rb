class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
 
  def index
    @recipes = Recipe.published
    .with_attached_image
    .includes(user: { image_attachment: :blob })
    .search(params[:keyword])
    .order(created_at: :desc)
  end

  def show
    @recipe = Recipe
    .with_attached_image
    .find(params[:id])

    @comments = @recipe.comments
    .includes(user: { image_attachment: :blob })
    .order(created_at: :desc)

    @memo = Memo.find_or_initialize_by(recipe: @recipe, user: current_user)
  end

  def new
    @recipe = Recipe.new
  end

  def create
     @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      if @recipe.draft?
        redirect_to user_path(current_user), notice: "下書きを保存しました"
      else
        redirect_to recipe_path(@recipe), notice: "投稿に成功しました"
      end
    else
      render :new
    end
  end

  def edit
  end


  def update
    @recipe = current_user.recipes.find(params[:id])

    if @recipe.update(recipe_params)
      if @recipe.draft?
        redirect_to user_path(current_user), notice: "下書きに戻しました"
      else
        redirect_to recipe_path(@recipe), notice: "公開しました"
      end
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
    params.require(:recipe).permit(:title, :body, :image, :status)
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
