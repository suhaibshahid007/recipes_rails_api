class Api::RecipesController < Api::BaseController
  # jitera-anchor-dont-touch: before_action_filter
  before_action :doorkeeper_authorize!, only: %w[index show update destroy]
  before_action :current_user_authenticate, only: %w[index show update destroy]

  before_action :set_recipe
  before_action :set_rating, only: %i[show update destroy]

  def index
    @ratings = @recipe.ratings.includes(:user)
    render json: @ratings
  end

  def show
    render json: @rating
  end

  def create
    @rating = Rating.new(rating_params.merge!(user_id: 1, recipe_id: @recipe.id))
    if @rating.save
      render json: @rating, status: :ok
    else
      render json: { errors: @rating.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @rating

    if @rating.update(rating_params)
      render json: @rating, status: :ok
    else
      render json: { errors: @rating.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @rating

    @rating.destroy
  end

  private

  def rating_params
    params.require(:rating).permit(:score)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:recipe_id])
  end

  def set_rating
    @rating = Rating.find_by(id: params[:id])
  end
end
