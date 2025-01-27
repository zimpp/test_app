class CreateInterests < ActiveRecord::Migration[7.1]
  def change
    create_table :interests do |t|
      t.string :name
    end

    add_index :interests, :name, unique: true
  end
end
