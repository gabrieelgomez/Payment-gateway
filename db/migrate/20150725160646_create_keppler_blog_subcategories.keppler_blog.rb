# This migration comes from keppler_blog (originally 20150715002011)
class CreateKepplerBlogSubcategories < ActiveRecord::Migration
  def self.up
    create_table :keppler_blog_subcategories do |t|
      t.string :name
      t.string :permalink
      t.integer :category_id

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :keppler_blog_subcategories
  end

end
