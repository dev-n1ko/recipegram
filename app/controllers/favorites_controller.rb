class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    current_user.favorites.create(recipe: @recipe)
    @recipe.reload
    
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: recipes_path }
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    current_user.favorites.find_by(recipe: @recipe)&.destroy
    @recipe.reload

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: recipes_path }
    end
  end
end
