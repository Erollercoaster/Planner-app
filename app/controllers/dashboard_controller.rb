class DashboardController < ApplicationController   
  def index
    @incomplete_tasks_count = current_user.tasks.incomplete.count
    @most_urgent_task = current_user.tasks.incomplete.order(:due_date).first
    @tasks = current_user.tasks.incomplete.order(:due_date)
    @category = current_user.categories.build
  end
end