class CreateStressSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :stress_surveys do |t|
      t.integer :user_id
      t.integer :p1
      t.integer :p2
      t.integer :p3
      t.integer :p4
      t.integer :p5
      t.integer :p6
      t.integer :p7
      t.integer :score

      t.timestamps
    end
  end
end
