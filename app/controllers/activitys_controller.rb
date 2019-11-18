class ActivitysController < ApplicationController
  layout 'template'

  def index
    @activitys = Activity.all.paginate page: params[:page], per_page: 18
  end

  def create
    @activity = Activity.new(params.require(:activity).permit(:name, :desc, :date, :address))
    if @activity.save
      flash["success"] = "添加成功"
    else
      flash["danger"] = "添加失败#{@activity.errors.full_messages[0]}"
    end
    redirect_to activitys_url
  end

  def show
    @activity = Activity.find params[:id]
  end

  def delete
    @activity = Activity.find params[:id]
    @activity.destroy
    redirect_to activitys_path
  end

end
