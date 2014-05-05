class Admin::ManufacturerController < AuthenticationController
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
      @manufacturer = Manufacturer.find(params[:id])
      @page_title = 'Editar Fabricante'
  end

  def update
      @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update_attributes(params[:manufacturer])
      flash[:notice] = "El Fabricante #{@manufacturer.name} ha sido actualizado."
      redirect_to :action => 'show', :id => @manufacturer
    else
      @page_title = 'Editar Fabricante'
      render :action => 'edit'
    end
  end

  def destroy
      @manufacturer = Manufacturer.find(params[:id])
      @manufacturer.destroy
      flash[:notice] = "Se ha eliminado el Fabricante #{@manufacturer.name}."
      redirect_to :action => 'index'
  end

  def show
      @manufacturer = Manufacturer.find(params[:id])
      @page_title = @manufacturer.name
  end

  def index
      sorter_by = params[:sort_by]
      @manufacturers    = Manufacturer.paginate :page => params[:page], :order => sorter_by, :per_page => 5
      @page_title = 'Listando Fabricantes'
  end
end
