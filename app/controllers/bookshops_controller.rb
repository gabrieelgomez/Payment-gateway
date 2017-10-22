#Generado con Keppler.
class BookshopsController < ApplicationController  
  before_filter :authenticate_user!
  layout 'admin/application'
  load_and_authorize_resource
  before_action :set_bookshop, only: [:show, :edit, :update, :destroy]

  # GET /bookshops
  def index
    bookshops = Bookshop.searching(@query).all
    @objects, @total = bookshops.page(@current_page), bookshops.size
    redirect_to bookshops_path(page: @current_page.to_i.pred, search: @query) if !@objects.first_page? and @objects.size.zero?
  end

  # GET /bookshops/1
  def show
  end

  # GET /bookshops/new
  def new
    @bookshop = Bookshop.new
  end

  # GET /bookshops/1/edit
  def edit
  end

  # POST /bookshops
  def create
    @bookshop = Bookshop.new(bookshop_params)

    if @bookshop.save
      redirect_to @bookshop, notice: 'Bookshop was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bookshops/1
  def update
    if @bookshop.update(bookshop_params)
      redirect_to @bookshop, notice: 'Bookshop was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bookshops/1
  def destroy
    @bookshop.destroy
    redirect_to bookshops_url, notice: 'Bookshop was successfully destroyed.'
  end

  def destroy_multiple
    Bookshop.destroy redefine_ids(params[:multiple_ids])
    redirect_to bookshops_path(page: @current_page, search: @query), notice: "Usuarios eliminados satisfactoriamente" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookshop
      @bookshop = Bookshop.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bookshop_params
      params.require(:bookshop).permit(:name, :place, :attendat, :phone, :email, :address)
    end
end
