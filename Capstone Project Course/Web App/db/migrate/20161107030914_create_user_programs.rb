class CreateUserPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :user_programs do |t|
      t.integer :user_id
      t.integer :program_id
      t.integer :current_sound
      t.timestamps
    end
  end
end
