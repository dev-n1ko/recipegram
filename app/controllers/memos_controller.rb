class MemosController < ApplicationController
 before_action :authenticate_user!

  def create
    recipe = Recipe.find(params[:recipe_id])
    memo = current_user.memos.new(memo_params)
    memo.recipe = recipe

    if memo.save
      redirect_to recipe_path(memo.recipe)
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  def update
    memo = current_user.memos.find(params[:id])

    if memo.update(memo_params)
      redirect_to recipe_path(memo.recipe)
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:content)
  end
end

