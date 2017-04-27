class AddTypeSexAgeProgramYearToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :academic_type, :string
    add_column :users, :sex, :string
    add_column :users, :age, :int
    add_column :users, :school, :string
    add_column :users, :year, :int
    add_column :users, :rut, :int
  end
end
