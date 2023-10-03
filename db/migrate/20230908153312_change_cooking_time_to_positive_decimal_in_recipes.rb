class ChangeCookingTimeToPositiveDecimalInRecipes < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, :cooking_time, :decimal, precision: 10, scale: 2, default: 0, null: false, check: "cooking_time >= 0"
    change_column :recipes, :preparation_time, :decimal, precision: 10, scale: 2, default: 0, null: false, check: "preparation_time >= 0"
  end
end
