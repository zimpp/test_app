class CreateSkils < ActiveRecord::Migration[7.1]
  def change
    create_table :skils do |t|
      t.string :name
    end

    add_index :skils, :name, unique: true
  end
end
