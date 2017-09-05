# This migration comes from keppler_catalogs (originally 20150717154839)
class CreateKepplerCatalogsCategories < ActiveRecord::Migration
  def self.up
    create_table :keppler_catalogs_categories do |t|
      t.string :name
      t.string :permalink

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :keppler_catalogs_categories
  end

end
