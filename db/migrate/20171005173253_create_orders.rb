class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.boolean :paid
      t.integer :course_id

      t.timestamps null: false
    end
  end
end
