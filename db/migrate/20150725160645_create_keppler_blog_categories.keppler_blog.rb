# This migration comes from keppler_blog (originally 20150714192018)
class CreateKepplerBlogCategories < ActiveRecord::Migration
  def self.up
    create_table :keppler_blog_categories do |t|
      t.string :name
      t.string :permalink

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :keppler_blog_categories
  end

end
