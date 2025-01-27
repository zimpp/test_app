class RenameSkilToSkill < ActiveRecord::Migration[7.1]
  def up
    rename_table :skils, :skills
    rename_table :skils_users, :skills_users
    rename_column :skills_users, :skil_id, :skill_id
  end

  def down
    rename_table :skills, :skils
    rename_table :skills_users, :skils_users
    rename_column :skils_users, :skill_id, :skil_id
  end
end
