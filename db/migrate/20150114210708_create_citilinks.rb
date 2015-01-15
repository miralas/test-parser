class CreateCitilinks < ActiveRecord::Migration
  def change
    create_table :citilinks do |t|
      t.string :supplier_no
      t.string :price
      t.string :name
      t.string :category_adress

      t.timestamps null: false
    end
  end
end
