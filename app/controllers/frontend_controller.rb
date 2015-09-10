  class FrontendController < ApplicationController
	layout 'layouts/frontend/application'
	
  def index
  	@catalog_clientes = KepplerCatalogs::Catalog.find_by_section("Clientes")
  	@attachments_clientes = @catalog_clientes.attachments.where(public: true)

  	@catalog_testimonios = KepplerCatalogs::Catalog.find_by_section("Testimonios")
  	@attachments_testimonios = @catalog_testimonios.attachments.where(public: true)

  	@catalog_conferencias = KepplerCatalogs::Catalog.find_by_section("Conferencias")
  	@attachments_conferencias = @catalog_conferencias.attachments.where(public: true)		
  end

  def gallery
    @catalog = KepplerCatalogs::Catalog.find_by_section("Galeria")
    @category = KepplerCatalogs::Category.find_by_permalink(params[:category_permalink])
    @attachments = @catalog.attachments.where(category_id: @category.id, public: true).page(@current_page).per(6)
  end

end
