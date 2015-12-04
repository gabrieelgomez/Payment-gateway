class NewslettersController < ApplicationController

  # GET /newsletters
  # GET /newsletters.json
  def index
    #@newsletters = Newsletter.all
  end
  # GET /newsletters/1
  # GET /newsletters/1.json
  def show
  end

  # GET /newsletters/new
  def new
    @newsletter = Newsletter.new
  end

  # GET /newsletters/1/edit
  def edit
  end

  def download
    @filename ="#{Rails.root}/app/assets/images/frontend/Llamados_para_triunfar_GUSTAVO_HENAO.mp3"
    send_file(@filename,
      :type => 'audio/mp3',
      :disposition => 'attachment',
      :x_sendfile => true)
  end

  # POST /newsletters
  # POST /newsletters.json
  def create
    @newsletter = Newsletter.new(newsletter_params)

    respond_to do |format|
      if @newsletter.save
        @@gibbon.lists("86f169fb8e").members.create(body:{email_address: @newsletter.email, status: "subscribed"})   
        format.html { redirect_to downloader_path, notice: 'Se ha suscrito correctamente'}
      else
        format.html { redirect_to gallery_path("audios"), notice: 'Ya te encuentras registrado o ocurrio un error' }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsletters/1
  # PATCH/PUT /newsletters/1.json
  def update
    respond_to do |format|
      if @newsletter.update(newsletter_params)
        format.html { redirect_to @newsletter, notice: 'Newsletter was successfully updated.' }
        format.json { render :show, status: :ok, location: @newsletter }
      else
        format.html { render :edit }
        format.json { render json: @newsletter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsletters/1
  # DELETE /newsletters/1.json
  def destroy
    @newsletter.destroy
    respond_to do |format|
      format.html { redirect_to newsletters_url, notice: 'Newsletter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
      @newsletter = Newsletter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsletter_params
      params.require(:newsletter).permit(:email)
    end
end
