class Admin::GlassesController < ApplicationController
  def new
    @glasses    = Glasses.new
    @page_title = 'Crear nuevas Gafas'
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @glasses    = Glasses.find(params[:id])
    @page_title = @glasses.name
  end

  def index
    @glasses    = Glasses.find(:all)
    @page_title = 'Listando Gafas'
  end
end
