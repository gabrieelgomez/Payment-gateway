# This migration comes from keppler_catalogs (originally 20150716201558)
class CreateKepplerCatalogsCatalogs < ActiveRecord::Migration
  def self.up
    create_table :keppler_catalogs_catalogs do |t|
      t.string :cover
      t.string :name
      t.text :description
      t.string :section
      t.boolean :public
      t.string :permalink

      t.timestamps null: false
    end
  end


  def self.down
    drop_table :keppler_catalogs_catalogs
  end
end
