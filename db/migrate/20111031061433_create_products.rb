class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.decimal :tax_percent
      t.boolean :discontinued
      t.integer :category_id

      t.timestamps
    end
  end
end
