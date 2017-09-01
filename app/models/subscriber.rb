#Generado por keppler
require 'elasticsearch/model'
class Subscriber < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :course, counter_cache: true

  after_commit on: [:update] do
    puts __elasticsearch__.index_document
  end

  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]

  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = 'hpk7pj9sx4fkg5df'
  Braintree::Configuration.public_key = 'mbf2j8k2kn9md6dr'
  Braintree::Configuration.private_key = '4ec74eab16cea191d4002387fa81ec1c'

  def self.payment_method(params, amount, subscriber_params)

    nonce = params["payment_method_nonce"]
    result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      :options => {
        :submit_for_settlement => true
      }
    )
    result.success? ? @checkout = result.transaction.id : @checkout = false
    @checkout
  end

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
