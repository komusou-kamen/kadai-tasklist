class TasksController < ApplicationController
  before_action :require_user_logged_in
  #before_action :set_task, only: [:update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy ]
  
  
  def index
    @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end

  def show
  end

  def new
      @task = current_user.tasks.build
  end

  def create
      @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'タスク が正常に作成されました'
      redirect_to @task
      #redirect_to tasks_path # indexに飛ばしたい場合はこれでOK
      
    else
      flash.now[:danger] = 'タスク が作成されませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  #def set_task
  #  @task = Task.find(params[:id])
  #end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  #def check_user
   # if current_user.id == Task.find_by_id(params[:id]).try(:user_id)
    #  @task = Task.find(params[:id])
    #else 
    #  redirect_to root_path
      #@task = nil
    #end
    # 参考
    #unless current_user.tasks.where(id: params[:id])
    #  redirect_to root_path 
    #end
#  end


  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

end
