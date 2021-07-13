class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, default: 0.0
      t.text :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
