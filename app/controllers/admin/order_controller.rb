# encoding: UTF-8
class Admin::OrderController < Admin::AuthenticatedController
  def close
    order = Order.find(params[:id])
    order.close
    flash[:notice] = "La orden ##{order.id} ha sido cerrada."
    redirect_to :action => 'index'
  end

  def show
    @order = Order.find(params[:id])
    @page_title = "Mostrando orden ##{@order.id}"
  end
  def destroy
      @order = Order.find(params[:id])
      @order.destroy
      flash[:notice] = "Se ha eliminado el pedido #{@order.id}."
      redirect_to :action => 'index'
  end
  def index
    @status = params[:id]
    if @status.blank?
      @status = 'all'
      conditions = nil
    else
      conditions = "status = '#{@status}'"
    end
    @orders = Order.paginate :page => params[:page], :conditions => conditions, :per_page => 5
    @page_title = "Listando #{@status} órdenes de pedido"
  end
end
