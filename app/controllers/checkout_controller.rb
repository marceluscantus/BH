# encoding: UTF-8
class CheckoutController < ApplicationController
  before_filter :initialize_cart, :only => :index

  def index
    @order = Order.new
    @page_title = 'Checkout'
    if @cart.glasses.empty?
      flash[:notice] = 'El carro está vacío! ' +
                       'Por favor, añada algún artículo antes de procesar su pedido.'
      redirect_to :controller => 'catalog'
    end
  end

  def submit_order
    @cart = Cart.find(params[:cart][:id]) # Search the cart from the cart id hidden field of the form
    @order = Order.new(params[:order])
    @order.customer_ip = request.remote_ip
    @order.status = 'open'
    @page_title = 'Checkout'
    populate_order

    if @order.save
      if @order.process
        flash[:notice] = 'Su orden ha sido enviada y será procesada inmediatamente.'
        session[:order_id] = @order.id
        @cart.cart_items.destroy_all # empty shopping cart
        redirect_to :action => 'thank_you'
      else
        flash[:notice] = "Error al enviar orden '#{@order.error_message}'."
        render :action => 'index'
      end
    else
      render :action => 'index'
    end
  end

  def thank_you
    @page_title = 'Thank you.'
  end

  private

  def populate_order
    for cart_item in @cart.cart_items
      order_item = OrderItem.new(:glasses_id => cart_item.glasses_id,
                                 :price => cart_item.price,
                                 :amount => cart_item.amount)
      @order.order_items << order_item
    end
  end
end
