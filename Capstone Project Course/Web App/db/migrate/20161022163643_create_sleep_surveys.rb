class CreateSleepSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :sleep_surveys do |t|
      t.integer :user_id
      t.float :p1
      t.float :p2
      t.string :p3
      t.string :p4
      t.string :p5
      t.string :p6
      t.string :p7
      t.string :p8
      t.string :p9
      t.string :p10
      t.string :p11
      t.string :p12
      t.string :result
      t.integer :score


      t.timestamps
    end
  end
end
