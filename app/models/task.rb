class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :detail, presence: true
  scope :search, -> (params) {where('(task_name LIKE ?) AND (status LIKE ?)',
                                  "%#{params[:task][:task_name_key]}%",
                                  "%#{params[:task][:status_key]}%")}
end
