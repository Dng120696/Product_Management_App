class Owner::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_product,only: [:show,:edit,:update,:destroy]
  before_action :categories,only: [:new,:edit, :update]

  def index
    @products = current_admin.products
  end

  def new
    @product = current_admin.products.new
  end

  def edit;end

  def show;end

  def create
    @product = current_admin.products.new(product_params)

    if @product.save
      redirect_to owner_products_path, notice: 'Product was successfully created.'
    else
      render new_owner_product_path
    end
  end

  def update
    if @product.update(product_params)
      redirect_to owner_products_path, notice: 'Product was successfully updated.'
    else
      render new_owner_product_path
    end
  end

  def destroy
      @product.destroy
      redirect_to owner_products_path, notice: 'Product was successfully destroyed.'

  end

  private

  def categories
    @categories ||= Category.all
  end

  def find_product
    @product = current_admin.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :weight, :description, :brand_id, :inventory_level,:product_type, categories: [])
  end
end
