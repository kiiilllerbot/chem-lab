class CreateElements < ActiveRecord::Migration[6.1]
  def change
    create_table :elements do |t|
      t.string :name
      t.integer :atomic_number
      t.decimal :atomic_mass
      t.string :symbol
      t.text :description
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
