class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :lastname
      t.string :document_id
      t.string :email
      t.bigint :phone_one
      t.bigint :phone_two
      t.text :address
      t.integer :course_id
      t.string :payment
      t.float :buyout
      t.string :bill

      t.timestamps null: false
    end
  end
end
