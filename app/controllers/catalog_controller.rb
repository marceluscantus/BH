class CatalogController < ApplicationController
  before_filter :initialize_cart, :except => [:show, :latest]
  before_filter :require_no_user
  
  def show
    @glasses = Glasses.find(params[:id])
    @page_title = @glasses.name
  end
  
  def index
    @glasses = Glasses.paginate :page => params[:page], :order => "glasses.id desc", :per_page => 5, :include => [:manufacturer]
    @page_title = 'Catalogo'
  end
  
  def latest
    @glasses = Glasses.latest 5 # invoca al metodo "lastest" para sacar los cinco ultimos libros
    @page_title = "Últimos modelos"
  end
end
