class TasksController < ApplicationController
  before_action :set_category
  before_action :set_task, only: [:show, :edit, :update, :destroy, :update_completion]

  def update_completion
    @task.update(completed: !@task.completed)
    redirect_to category_path(@category), notice: 'Task completion status updated.'
  end

  def index
    @tasks = @category.tasks
  end

  def show
  end

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.build(task_params)
    @task.user = current_user
    if @task.save
      flash[:notice] = 'Task was successfully created.'
      redirect_to category_path(@category)
    else
      flash.now[:alert] = 'There were problems creating the task.'
      render turbo_stream: turbo_stream.replace('task-modal-form', partial: 'tasks/task_form', locals: { task: @task })
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:notice] = 'Task was successfully updated.'
      redirect_to category_path(@category)
    else
      flash.now[:alert] = 'There were problems updating the task.'
      render turbo_stream: turbo_stream.replace('task-modal-form', partial: 'tasks/task_form', locals: { task: @task })
    end
  end

  def destroy
    @task.destroy
    redirect_to category_path(@category), notice: 'Task was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to category_path(@category)
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed)
  end
end