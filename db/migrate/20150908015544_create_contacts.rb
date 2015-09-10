class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :conferences
      t.string :names
      t.string :company
      t.string :estimated_date
      t.string :type_meeting
      t.string :theme
      t.string :start_time
      t.string :end_time
      t.string :city
      t.string :assistants
      t.string :phone
      t.string :email
      t.string :message

      t.timestamps null: false
    end
  end
end
