class CustomerClient::CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart || current_user.create(user_id: current_user.id)
    @cart_item = @cart.cart_items.find_or_initialize_by(product_id: params[:cart_item][:product_id])
    @cart_item.quantity += params[:cart_item][:quantity].to_i
    if @cart_item.save
      redirect_to cart_path(@cart), notice: 'Product added to cart.'
    else
      redirect_to products_path, alert: 'Unable to add product to cart.'
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(@cart_item.cart), notice: 'Product removed from cart.'
  end
end
