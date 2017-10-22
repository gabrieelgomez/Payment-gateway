class CreateBookshops < ActiveRecord::Migration
  def change
    create_table :bookshops do |t|
      t.string :name
      t.string :place
      t.string :attendat
      t.bigint :phone
      t.string :email
      t.string :address

      t.timestamps null: false
    end
  end
end
