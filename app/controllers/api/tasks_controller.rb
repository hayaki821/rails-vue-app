class Api::TasksController < ApplicationController
  # これ必要
  protect_from_forgery
  
    # GET /tasks
  def index
    # 後々のため、更新順で返します
    key = 'updated_at'
    # get model older DESC
    @tasks = Task.order(key+' '+'DESC')
  end

  # POST /tasks
  def create
    # create model
    @task = Task.new(task_params)

    # db save
    # if save OK
    if @task.save
    # statusはステータスコードを制御
    # taskディレクトリのshow.html.erbを表示
        render :show, status: :created
    # save NG
    else
        render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
        render :show, status: :ok
    else
        render json: @task.errors, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    # 指定したキーがないときにエラーを出さないようにする
    def task_params
        params.fetch(:task, {}).permit(
            :name, :is_done
        )
    end
end
