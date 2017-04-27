class AddRecommendationsToStressSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :stress_surveys, :recommendations, :text
  end
end
