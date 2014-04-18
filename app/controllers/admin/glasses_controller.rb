class Admin::GlassesController < ApplicationController
  def new
    load_data
    @glasses    = Glasses.new
    @page_title = 'Crear nuevas Gafas'
  end

  def create
    @glasses = Glasses.new(params[:glasses])
    if @glasses.save
      flash[:notice] = "Las Gafas #{@glasses.name} han sido creadas con exito."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Crear nuevas Gafas'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @glasses = Glasses.find(params[:id])
    @page_title = 'Editar Gafas'
  end

  def update
    @glasses = Glasses.find(params[:id])
    if @glasses.update_attributes(params[:glasses])
      flash[:notice] = "Las Gafas #{@glasses.name} han sido actualizadas."
      redirect_to :action => 'show', :id => @glasses
    else
      load_data
      @page_title = 'Editar Gafas'
      render :action => 'edit'
    end
  end

  def destroy
    @glasses = Glasses.find(params[:id])
    @glasses.destroy
    flash[:notice] = "Las Gafas #{@glasses.name} han sido eliminadas."
    redirect_to :action => 'index'
  end

  def show
    @glasses    = Glasses.find(params[:id])
    @page_title = @glasses.name
  end

  def index
    @glasses    = Glasses.find(:all)
    @page_title = 'Listando Gafas'
  end
  
  private

    def load_data
      @manufacturers = Manufacturer.find(:all)
    end
end
