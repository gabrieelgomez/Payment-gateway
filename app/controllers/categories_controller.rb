#Generado con Keppler.
class CategoriesController < ApplicationController  
  before_filter :authenticate_user!
  layout 'admin/application'
  load_and_authorize_resource
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  def index
    categories = Category.searching(@query).all
    @objects, @total = categories.page(@current_page), categories.size
    redirect_to categories_path(page: @current_page.to_i.pred, search: @query) if !@objects.first_page? and @objects.size.zero?
  end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  def destroy_multiple
    Category.destroy redefine_ids(params[:multiple_ids])
    redirect_to categories_path(page: @current_page, search: @query), notice: "Usuarios eliminados satisfactoriamente" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name)
    end
end
