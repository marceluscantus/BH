class Admin::ManufacturerController < ApplicationController
  def new
      @manufacturer = Manufacturer.new
      @page_title = 'Crear nuevo Fabricante'
  end

  def create
   @manufacturer = Manufacturer.new(params[:manufacturer])
    if @manufacturer.save
      flash[:notice] = "Fabricante #{@manufacturer.company_name} ha sido creado con exito."
      redirect_to :action => 'index'
    else
      @page_title = 'Crear nuevo Fabricante'
      render :action => 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
      @manufacturer = Manufacturer.find(params[:id])
      @page_title = @manufacturer.name
  end

  def index
       @manufacturers = Manufacturer.find(:all)
       @page_title = 'Listando Fabricantes'
  end
end
