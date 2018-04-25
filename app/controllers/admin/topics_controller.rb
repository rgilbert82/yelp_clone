class Admin::TopicsController < Admin::AdminsController
  def destroy
    topic = Topic.find(params[:id])
    topic.destroy
    redirect_back(fallback_location: topics_path)
  end
end
