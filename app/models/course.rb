#Generado por keppler
require 'elasticsearch/model'
class Course < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :category
  has_many :subscribers
  mount_uploader :banner, ImageUploader
  validates :course_name, :banner, :quota, :price_dolars, :price_bs, presence: {message: "El campo no puede estar vacío"}


  after_commit on: [:update] do
    puts __elasticsearch__.index_document
  end


  def validate_subscribers
    if quota_count.zero?
      errors.add(:quota, "No quedan cupos disponibles para este curso")
    end
  end

  def quota_count
    quota-subscribers_count
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
      course_name:  self.course_name.to_s,
      category_id:  self.category_id.to_s,
      banner:  self.banner.to_s,
      description:  self.description.to_s,
      quota:  self.quota.to_s,
      price_dolars:  self.price_dolars.to_s,
      price_bs:  self.price_bs.to_s,
    }.as_json
  end

end
#Course.import
