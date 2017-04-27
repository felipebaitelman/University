class AddRecommendationsToSleepSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :sleep_surveys, :recommendations, :text
  end
end
