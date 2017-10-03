class PaymentsController < ApplicationController
  before_action :set_category, only: [:payments, :courses_categories]


  def payments
    @subscriber = Subscriber.new
    @values = {
        business: "gagg1707_vendedor_seller@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "localhost:3000/payments/1/mercadopago",
        invoice: 909011,
        amount: 12,
        item_name: "teste de snowden",
        item_number: 9029011,
        quantity: '1',
        notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
  end

  def categories
    @categories = Category.all.reverse
    @courses = Course.all.reverse
  end

  def courses_categories
  end

  def checkout_mercadopago
    @preference = Subscriber.buy_mercadopago(params)
  end

  def checkout
    @course = Course.find(subscriber_params[:course_id])

    if subscriber_params[:payment].eql?("mercadopago")

      amount = "#{@course.price_bs}"
      @subscriber = Subscriber.new(subscriber_params.merge(buyout: "#{amount}"))

      if @subscriber.save
        redirect_to checkout_id_path(@subscriber.bill.to_i)
      else
        redirect_to checkout_id_path("Braintree_errors")
      end

    else
      #@checkout = Subscriber.payment_method(params,amount,subscriber_params)
      # if @subscriber.save
			values = {
					business: "gagg1707_vendedor_seller@gmail.com",
					cmd: "_xclick",
					upload: 1,
					return: "localhost:300/payments/1/paypal",
					invoice: 909011,
					amount: 12,
					item_name: "teste de snowden",
					item_number: 9029011,
					quantity: '1',
          notify_url: "localhost:300/payments/1/paypal"
			}
			redirect_to  "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
      # else
      #   render :new
      # end
    end
  end

  def checkout_id
    @subscriber = Subscriber.searching_checkout(params[:id])
  end

  def set_category
    @course = Course.find(params[:id])
  end

  def subscriber_params
    params.require(:subscriber).permit(:name, :lastname, :document_id, :email, :phone_one, :phone_two, :address, :course_id, :bill, :buyout, :payment)
  end


end
