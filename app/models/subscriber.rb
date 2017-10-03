#Generado por keppler
require 'elasticsearch/model'
class Subscriber < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :course, counter_cache: true
  validates :bill, uniqueness: true
  require 'mercadopago.rb'

  after_commit on: [:update] do
    puts __elasticsearch__.index_document
  end


  def self.buy_mercadopago(params)
    $mp = MercadoPago.new('7540776543610704', 'hya2kL3DVD1NnQMTs4LgLa3KLOn1c4PT')

    preference_data = {
      :items => [
          {
          :id => "#{Course.find(params[:id]).subscribers_count}",
          :title => "#{Course.find(params[:id]).course_name}",
          :quantity => 1,
          :unit_price => Course.find(params[:id]).price_bs,
          :currency_id => "VEF"
          }
        ],
      :back_urls => {
        :success => "localhost:3000/payments/#{params[:id]}/mercadopago",
        :failure => "localhost:3000/checkout/Braintree_errors"
      },
      :auto_return => "approved",
      :payment_methods => {
          # :excluded_payment_methods => [
          #   {
          #   :id => "amex"
          #   }
          # ],
          :excluded_payment_types => [
              {
              :id => "ticket"
              },
              {
              :id => "bank_transfer"
              },
              {
              :id => "discount"
              }
            ],
          },
          # :notification_url => "localhost:3000/checkout/asd99",
      }

    @preference = $mp.create_preference(preference_data)
  end

	serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "gagg1707_vendedor_seller@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "localhost:3000/payments/1/mercadopago",
        invoice: 909090909090909209090,
        amount: 12,
        item_name: "teste de snowden",
        item_number: 902909099012323,
        quantity: '1',
				notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    redirect_to  "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

#  def paypal_url(return_path)
#    values = {
#        business: "merchant@gotealeaf.com",
#        cmd: "_xclick",
#        upload: 1,
#        return: "#{Rails.application.secrets.app_host}#{return_path}",
#        invoice: id,
#        amount: course.price,
#        item_name: course.name,
#        item_number: course.id,
#        quantity: '1',
#        notify_url: "#{Rails.application.secrets.app_host}/hook"
#    }
#    "#{Rails.application.secrets.paypal.fetch(:host)}#{values.to_query}"
#  end

  def self.searching_checkout(checkout)
    Subscriber.all.where(bill: "#{checkout}").first
  end

  def self.searching(query)
    if query
      self.search(self.query query).records.order(id: :desc)
    else
      self.order(id: :desc)
    end
  end

  def self.query(query)
    { query: { multi_match:  { query: query, fields: [] , operator: :and }  }, sort: { id: "desc" }, size: self.count }
  end

  #armar indexado de elasticserch
  def as_indexed_json(options={})
    {
      id: self.id.to_s,
      name:  self.name.to_s,
      lastname:  self.lastname.to_s,
      document_id: self.document_id.to_s,
      email:  self.email.to_s,
      phone_one:  self.phone_one.to_s,
      phone_two:  self.phone_two.to_s,
      address:  self.address.to_s,
      course_id:  self.course_id.to_s,
      payment: self.payment.to_s,
      buyout: self.buyout.to_s,
      bill: self.bill.to_s,
    }.as_json
  end

end
#Subscriber.import
