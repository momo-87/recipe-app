class RemoveDefaultValuesFromRecipes < ActiveRecord::Migration[7.0]
  def change
    change_column_default :recipes, :cooking_time, nil
    change_column_default :recipes, :preparation_time, nil
  end
end
