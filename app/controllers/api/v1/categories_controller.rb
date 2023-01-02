class Api::V1::CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show update destroy merge ]
  before_action :authenticate_api_v1_user!

  # GET /api/v1/categories
  def index
    @categories = Category.all.where(user: current_api_v1_user)

    render json: @categories
  end

  # GET /api/v1/categories/1
  def show
    render json: @category
  end

  # POST /api/v1/categories
  def create
    @category = Category.new(category_params.merge(user: current_api_v1_user))

    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/categories/1
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/categories/1
  def destroy
    if @category.destroy
      render json: {success: true}, status: :ok
    else
      render json: {error: "Error while deleting the Category."}, status: :unprocessable_entity
    end
  end

  # POST /api/v1/categories/merge
  def merge
    if params[:new_category_id].present?
      if Transaction.where(category: @category).update(category_id: params[:new_category_id])
        @category.destroy
        render json: {success: true}, status: :ok
      else
        render json: {error: "Error while Merging Category."}, status: :internal_server_error
      end
    else
      render json: {error: "Missing New Category Id."}, status: :unprocessable_entity
    end
  end

  # POST /api/v1/categories/reorder
  def reorder
    if params[:category_ids].present?
      ids = Category.all.where(user: current_api_v1_user).pluck(:order)
      params[:category_ids].each_with_index do |id, i|
        Category.find(id).update!(order: ids[i])
      end
      render json: {success: true}, status: :ok
    else
      render json: {error: "Missing Category Ids."}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.where(user: current_api_v1_user).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.fetch(:category, {}).permit(:name, :income, :user_id)
    end
end
