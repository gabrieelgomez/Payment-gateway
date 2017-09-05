class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_name
      t.integer :category_id
      t.string :banner
      t.text :description
      t.integer :quota
      t.float :price_dolars
      t.float :price_bs
      t.integer :subscribers_count, default: 0

      t.timestamps null: false
    end
  end
end
