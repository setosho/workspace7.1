class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :detail, presence: true
  scope :task_name_search, -> (params) {where('(task_name LIKE ?)',"%#{params[:task][:task_name_key]}%")}
  scope :status_search, -> (params) {where(status: params[:status][:task_status_key])}
  enum priority: {not_entered: 0, low: 1, medium: 2, high: 3}
  enum status: {未着手: 1, 着手中: 2, 完了: 3}
end
