#Generado por keppler
require 'elasticsearch/model'
class Category < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :courses, :dependent => :delete_all
  validates :name, presence: {message: "El campo no puede estar vacío"}

  
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
    }.as_json
  end

end
#Category.import
