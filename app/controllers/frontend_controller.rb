class FrontendController < ApplicationController
  layout 'layouts/frontend/application'

  def index
    @catalog_clientes = KepplerCatalogs::Catalog.find_by_section("Clientes")
    @attachments_clientes = @catalog_clientes.attachments.where(public: true)

    @catalog_testimonios = KepplerCatalogs::Catalog.find_by_section("Testimonios")
    @attachments_testimonios = @catalog_testimonios.attachments.where(public: true)


    @catalog_conferencias = KepplerCatalogs::Catalog.find_by_section("Conferencias")
    @category_conferencias = KepplerCatalogs::Category.find_by_permalink("conferencias-individuales")

    @attachments_conferencias_i = @catalog_conferencias.attachments.where(category_id: @category_conferencias.id, public: true).order(id: :desc)
  end

  def gallery
    @catalog = KepplerCatalogs::Catalog.find_by_section("Galeria")
    @category = KepplerCatalogs::Category.find_by_permalink(params[:category_permalink])
    @attachments = @catalog.attachments.where(category_id: @category.id, public: true).page(@current_page).per(6)
  end

  def courses_front
    @categories = Category.all.reverse
    @courses = Course.all.reverse
  end

  def courses_categories
    @subscriber = Subscriber.new
    @course = Course.find(params[:id])
    @token = Braintree::ClientToken.generate
    require 'mercadopago.rb'
    $mp = MercadoPago.new('7540776543610704', 'hya2kL3DVD1NnQMTs4LgLa3KLOn1c4PT')

    preference_data = {
                "items": [
                    {
                        "title": "testCreate",
                        "quantity": 1,
                        "unit_price": 10.2,
                        "currency_id": "ARS"
                    }
                ]
            }
    @preference = $mp.create_preference(preference_data)

  end

  def mercadopago
  end

  def checkout
    @course = Course.find(subscriber_params[:course_id])
    subscriber_params[:payment].eql?("paypal") ? amount = "#{@course.price_dolars}" : amount = "#{@course.price_bs}"
    @checkout = Subscriber.payment_method(params,amount,subscriber_params)

    if @checkout
      @subscriber = Subscriber.new(subscriber_params.merge(bill: @checkout, buyout: "#{amount}"))
        if @subscriber.save
          redirect_to checkout_id_path(@checkout)
        else
          puts"Error en guardar subscriptor"
        end
    else
      puts"Error en el pago"
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      #flash[:error] = error_messages
      redirect_to root_path
    end

  end

  def checkout_id
    @subscriber = Subscriber.searching_checkout(params[:id])
  end

  def subscriber_params
    params.require(:subscriber).permit(:name, :lastname, :document_id, :email, :phone_one, :phone_two, :address, :course_id, :payment, :bill, :buyout)
  end

end
