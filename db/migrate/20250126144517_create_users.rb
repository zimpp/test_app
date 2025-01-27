class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.string :surname
      t.string :patronymic
      t.string :user_full_name
      t.string :nationality
      t.string :country
      t.integer :gender
      t.integer :age

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
