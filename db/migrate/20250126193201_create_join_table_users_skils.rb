class CreateJoinTableUsersSkils < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :skils do |t|
      t.index [:user_id, :skil_id]
    end
  end
end
