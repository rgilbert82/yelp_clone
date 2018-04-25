class Admin::PostsController < Admin::AdminsController
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_back(fallback_location: topics_path)
  end
end
