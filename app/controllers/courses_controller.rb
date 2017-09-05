#Generado con Keppler.
class CoursesController < ApplicationController  
  before_filter :authenticate_user!
  layout 'admin/application'
  load_and_authorize_resource
  before_action :set_category
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  def index
    #@course = Course.find(params[:id])
    courses = Course.searching(@query).where(category_id: @category_course.id)
    @objects, @total = courses.page(@current_page), courses.size
    redirect_to courses_path(page: @current_page.to_i.pred, search: @query) if !@objects.first_page? and @objects.size.zero?
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new(category_id: params[:category_id])
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to category_courses_path, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to category_courses_path, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  def destroy_multiple
    Course.destroy redefine_ids(params[:multiple_ids])
    redirect_to courses_path(page: @current_page, search: @query), notice: "Usuarios eliminados satisfactoriamente" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    def set_category
      @category_course = Category.find(params[:category_id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.require(:course).permit(:course_name, :category_id, :banner, :description, :quota, :price_dolars, :price_bs)
    end
end