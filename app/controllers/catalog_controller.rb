# encoding: UTF-8
class CatalogController < ApplicationController
  before_filter :initialize_cart
  before_filter :except => [:show, :latest]

  def show
    @glasses = Glasses.find(params[:id])
    @page_title = @glasses.name
  end
  
  def index
    @glasses = Glasses.paginate :page => params[:page], :order => "glasses.id desc", :per_page => 5, :include => [:manufacturer]
    @page_title = 'Catálogo'
  end
  
  def latest
    @glasses = Glasses.latest 5 # invoca al metodo "lastest" para sacar los cinco ultimos libros
    @page_title = "Últimos modelos"
  end

  def search
    @page_title = "Buscar"
    
    if params[:commit] == "Buscar" || params[:q]
      @glasses = Glasses.find_with_ferret(params[:q].to_s.upcase)
      unless @glasses.size > 0
        flash.now[:notice] = "No se encontraron resultados."
      end
    end
  end

  def rss
  	latest
  	render :layout => false
  	response.headers["Content-Type"] = "application/xml; version=1.0; charset=utf-8"
  end

end
