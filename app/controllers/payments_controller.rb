class PaymentsController < ApplicationController
  before_action :set_category, only: [:payments, :courses_categories]

  def categories
    @categories = Category.all.reverse
    @courses = Course.all.reverse
  end

  def courses_categories
  end

  def front_paypal
    @order = Order.new
    @token = Order.token
  end

  def transaction_paypal
    @order = Order.new(order_params)
    @order.save
    @paypal = Subscriber.paypal_payment(order_params)
    redirect_to  "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + @paypal.to_query
  end

  def checkout_paypal
    @order = Order.where(name:params[:id]).first
    if @order.paid?
      redirect_to checkout_id_path("Braintree_errors", @order)
    else
      @course = Course.find(@order.course_id)
      @subscriber = Subscriber.new
    end

  end

  def front_mercadopago
    @preference = Subscriber.buy_mercadopago(params)
  end

  def checkout_mercadopago
    @course = Course.find(params[:id])
    @subscriber = Subscriber.new
  end

  def checkout
    @course = Course.find(subscriber_params[:course_id])
    @amount = Subscriber.amount(subscriber_params, @course)
    @subscriber = Subscriber.new(subscriber_params.merge(buyout: "#{@amount}"))
    if @subscriber.save
      @orders = Order.where(name: "#{@subscriber.bill}")
          @orders.each do |order|
            order.update(paid: true)
          end
      redirect_to checkout_id_path(@subscriber.bill)
    else
      redirect_to checkout_id_path("Braintree_errors")
    end
  end

  def checkout_id
    @subscriber = Subscriber.searching_checkout(params[:id])
  end

  private

  def set_category
    @course = Course.find(params[:id])
  end

  def subscriber_params
    params.require(:subscriber).permit(:name, :lastname, :document_id, :email, :phone_one, :phone_two, :address, :course_id, :bill, :buyout, :payment)
  end

  def order_params
    params.require(:order).permit(:name, :course_id, :paid)
  end

end
