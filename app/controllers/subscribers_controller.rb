#Generado con Keppler.
class SubscribersController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin/application'
  load_and_authorize_resource
  before_action :set_course
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  # GET /subscribers
  def index
    subscribers = Subscriber.searching(@query).where(course_id: @course_subscriber.id)
    @objects, @total = subscribers.page(@current_page), subscribers.size
    redirect_to subscribers_path(page: @current_page.to_i.pred, search: @query) if !@objects.first_page? and @objects.size.zero?
  end

  # GET /subscribers/1
  def show
  end

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.new(category_id: params[:category_id])
  end

  # GET /subscribers/1/edit
  def edit
  end

  # POST /subscribers
  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      redirect_to category_course_subscribers_path, notice: 'Subscriber was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /subscribers/1
  def update
    if @subscriber.update(subscriber_params)
      redirect_to category_course_subscribers_path, notice: 'Subscriber was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /subscribers/1
  def destroy
    @subscriber.destroy
    redirect_to subscribers_url, notice: 'Subscriber was successfully destroyed.'
  end

  def destroy_multiple
    Subscriber.destroy redefine_ids(params[:multiple_ids])
    redirect_to subscribers_path(page: @current_page, search: @query), notice: "Usuarios eliminados satisfactoriamente"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    def set_course
      @course_subscriber = Course.find(params[:course_id])
    end

    # Only allow a trusted parameter "white list" through.
    def subscriber_params
      params.require(:subscriber).permit(:name, :lastname, :email, :phone_one, :phone_two, :address, :category_id)
    end
end
