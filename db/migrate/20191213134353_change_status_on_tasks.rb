class ChangeStatusOnTasks < ActiveRecord::Migration[5.2]
  def up
    change_table :tasks do |t|
      t.change :status, :integer
    end
  end

  def down
    change_table :users do |t|
      t.change :status, :string
    end
  end
end
