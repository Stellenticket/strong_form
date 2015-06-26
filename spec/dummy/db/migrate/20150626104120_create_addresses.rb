class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :country
      t.text :description
      t.references :user

      t.timestamps null: false
    end
  end
end
