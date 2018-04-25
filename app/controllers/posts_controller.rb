class PostsController < ApplicationController
  before_action :require_user

  def create
    @city = City.find_by slug: params[:city_id]
    @topic = Topic.find_by slug: params[:topic_id]
    @post = Post.new(post_params)
    @post.topic_id = @topic.id
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = "Thanks for posting!"
    else
      flash[:error] = "Oops! Your post can't be blank."
    end
    redirect_to city_topic_path(@city, @topic)
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
