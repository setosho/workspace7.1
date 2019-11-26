class ChangeColumnTasks2NotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :detail, :text, null: false
  end
end
