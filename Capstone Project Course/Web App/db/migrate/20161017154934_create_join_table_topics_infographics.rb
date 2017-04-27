class CreateJoinTableTopicsInfographics < ActiveRecord::Migration[5.0]
  def change
    create_join_table :infographics, :topics do |t|
      t.index [:infographic_id, :topic_id]
    end
  end
end
