class AddResultToStressSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :stress_surveys, :result, :string
  end
end
