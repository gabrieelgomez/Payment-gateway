#Generado por keppler
require 'elasticsearch/model'
class Bookshop < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  after_commit on: [:update] do
    puts __elasticsearch__.index_document
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
      place:  self.place.to_s,
      attendat:  self.attendat.to_s,
      phone:  self.phone.to_s,
      email:  self.email.to_s,
      address:  self.address.to_s,
    }.as_json
  end

end
#Bookshop.import
