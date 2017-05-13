class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.product_id = @product.id

    if @review.save
      redirect_to product_path(@product), notice: 'Review was successfully created.'
    else
      render :'products/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @product = Product.find(@review.product_id)
    if @review.destroy
      redirect_to product_path(@product)
    else
      render :'products/show'
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :description)
    end
end
