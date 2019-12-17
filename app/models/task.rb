class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :detail, presence: true
  scope :search, -> (params) {where('(task_name LIKE ?) AND (status LIKE ?)',
                                  "%#{params[:task][:task_name_key]}%",
                                  "%#{params[:task][:status_key]}%")}
  enum priority: {not_entered: 0, low: 1, medium: 2, high: 3}
  enum status: {not_started: 0, underway: 1, complete: 2}
end
