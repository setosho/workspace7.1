class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    if params[:sort_expired]
      @tasks = Task.order(deadline: :asc)
    elsif params[:sort_priority]
      @tasks = Task.order(priority: :desc)
    elsif params[:task] == nil
      @tasks = Task.order(created_at: :desc)
    elsif params[:task][:task_name_key].present? && params[:task][:status].present?
      @tasks = Task.where('task_name LIKE ?', "%#{params[:task][:task_name_key]}%").where(status: task_params[:status])
    elsif params[:task][:task_name_key].present? && params[:task][:status] == ""
      @tasks = Task.where('task_name LIKE ?', "%#{params[:task][:task_name_key]}%")
    elsif params[:task][:task_name_key].empty? && params[:task][:status].present?
      @tasks = Task.where(status: task_params[:status])
    end
    @tasks = @tasks.page(params[:page]).per(7)
  end



  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:task_name, :detail, :deadline, :status, :priority)
    end
end
