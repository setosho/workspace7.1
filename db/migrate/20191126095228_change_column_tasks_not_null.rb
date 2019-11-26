class ChangeColumnTasksNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :task_name, :string, null: false
  end
end
