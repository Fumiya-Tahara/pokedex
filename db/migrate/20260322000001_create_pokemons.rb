class CreatePokemons < ActiveRecord::Migration[8.1]
  def change
    create_table :pokemons do |t|
      t.integer :national_number, null: false
      t.string :name, null: false
      t.decimal :height, precision: 5, scale: 1, null: false
      t.decimal :weight, precision: 7, scale: 1, null: false

      t.timestamps
    end

    add_index :pokemons, :national_number, unique: true
  end
end
