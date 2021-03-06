# encoding: UTF-8
class CartController < ApplicationController
	before_filter :initialize_cart

	def add
    @glasses = Glasses.find params[:id]
    @page_title = 'Añadir producto'

    if request.xhr?
      @item = @cart.add params[:id]
      flash.now[:cart_notice] = "Añadido <em><b>#{@item.glasses.name}</b></em>".html_safe
      render :action => "add_with_ajax"
    elsif request.post?
      @item = @cart.add(params[:id])
      flash[:cart_notice] = "Añadido <em><b>#{@item.glasses.name}</b></em>.".html_safe
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'add', :template => 'cart/add'
    end
  end

  def remove
    @glasses = Glasses.find params[:id]
    @page_title = 'Eliminar producto'

    if request.xhr?
      @item = @cart.remove params[:id]
      flash.now[:cart_notice] = "Eliminado <em><b>#{@item.glasses.name}</b></em>".html_safe
      render :action => "remove_with_ajax"
    elsif request.post?
      @item = @cart.remove params[:id]
      flash[:cart_notice] = "Eliminado <em><b>#{@item.glasses.name}</em></b>".html_safe
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'remove', :template => 'cart/remove'
    end
  end

  def clear
    @page_title = 'Vaciar Carro'

    if request.xhr?
      @cart.cart_items.destroy_all
      flash.now[:cart_notice] = "Carro vaciado"
      render :action => "clear_with_ajax"
    elsif request.post?
      @cart.cart_items.destroy_all
      flash[:cart_notice] = "Carrito vaciado"
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'clear', :template => 'cart/clear'
    end
  end

end
