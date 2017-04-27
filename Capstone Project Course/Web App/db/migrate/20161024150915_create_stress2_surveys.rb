class CreateStress2Surveys < ActiveRecord::Migration[5.0]
  def change
    create_table :stress2_surveys do |t|
      t.integer :user_id
      t.string :result
      t.text :recommendation
      t.integer :score
      t.integer :p1
      t.integer :p2
      t.integer :p3
      t.integer :p4
      t.integer :p5
      t.integer :p6
      t.integer :p7
      t.integer :p8
      t.integer :p9
      t.integer :p10
      t.integer :p11
      t.integer :p12
      t.integer :p13
      t.integer :p14

      t.timestamps
    end
  end
end
