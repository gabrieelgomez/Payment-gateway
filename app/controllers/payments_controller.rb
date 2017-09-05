class PaymentsController < ApplicationController
  before_action :set_category, only: [:payments, :courses_categories]
  def payments
    @subscriber = Subscriber.new
    @token = Braintree::ClientToken.generate
    require 'mercadopago.rb'
    $mp = MercadoPago.new('7540776543610704', 'hya2kL3DVD1NnQMTs4LgLa3KLOn1c4PT')

    preference_data = {
                "items": [
                    {
                        "title": "testCreate",
                        "quantity": 1,
                        "unit_price": 1200,
                        "currency_id": "VEF"
                    }
                ]
            }
    @preference = $mp.create_preference(preference_data)
  end

  def categories
    @categories = Category.all.reverse
    @courses = Course.all.reverse
  end

  def courses_categories
  end

  def mercadopago
  end

  def checkout
    @course = Course.find(subscriber_params[:course_id])
    subscriber_params[:payment].eql?("paypal") ? amount = "#{@course.price_dolars}" : amount = "#{@course.price_bs}"
    @checkout = Subscriber.payment_method(params,amount,subscriber_params)


    if !@checkout.transaction.nil?
      @checkout = @checkout.transaction.id
      @subscriber = Subscriber.new(subscriber_params.merge(bill: @checkout, buyout: "#{amount}"))
        if @subscriber.save
          redirect_to checkout_id_path(@checkout)
        else
          puts"Error en guardar subscriptor"
        end
    else
      puts"Error en el pago"
      @checkout.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      redirect_to checkout_id_path("Braintree_errors")
      # error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      # #flash[:error] = error_messages
    end

  end

  def checkout_id
    @subscriber = Subscriber.searching_checkout(params[:id])
  end

  def set_category
    @course = Course.find(params[:id])
  end

  def subscriber_params
    params.require(:subscriber).permit(:name, :lastname, :document_id, :email, :phone_one, :phone_two, :address, :course_id, :payment, :bill, :buyout)
  end


end
