class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :detail, presence: true
  scope :search, -> (task_name, task_status) {where('(task_name LIKE ?) AND (status LIKE ?)',"%#{task_name}%", "%#{task_status}%")}
  enum priority: {not_entered: 0, low: 1, medium: 2, high: 3}
end
