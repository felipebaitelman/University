class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.datetime :date
      t.integer :user_id
      t.integer :media_id
      t.string  :media_type
      t.timestamps
    end
    add_index :logs, [:media_type, :media_id]
  end
end

