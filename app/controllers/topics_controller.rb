class TopicsController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :set_categories, only: [:index, :city_index, :show, :new]
  before_action :set_cities, only: [:index, :city_index, :show]
  before_action :set_city, only: [:city_index, :show, :new, :create]
  before_action :set_topic_categories, only: [:index, :city_index, :show, :new]
  before_action :set_topic, only: [:show]
  before_action :set_page, only: [:city_index, :show]

  def index
  end

  def city_index
    @count = (params[:count] || 1).to_i

    case @page
    when "all"
      @pages = number_of_pages(Topic.city_topics(@city))
      @topics = Topic.paginate_city_topics(@city, @count)
    when "my"
      @pages = number_of_pages(Topic.user_city_topics(current_user, @city))
      @topics = Topic.paginate_user_city_topics(current_user, @city, @count)
    else
      @pages = number_of_pages(Topic.city_category_topics(@city, @page.to_i))
      @topics = Topic.paginate_city_category_topics(@city, @page.to_i, @count)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
    @post = Post.new
  end

  def new
    @topic = Topic.new
  end

  def create
    values = topic_params
    values[:user_id] = current_user.id
    @topic = Topic.new(values.except(:post))

    if @topic.save
      @post = Post.new(user_id: values[:user_id], body: values[:post][:body], topic_id: @topic.id)

      if @post.save
        redirect_to city_topic_path(@topic.city, @topic)
      else
        @topic.destroy
        flash[:error] = "The topic must have a message."
        redirect_to new_city_topic_path(@city)
      end
    else
      flash[:error] = "The topic must have a name."
      redirect_to new_city_topic_path(@city)
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :topic_category_id, :city_id, post: [:body])
  end

  def set_topic_categories
    @topic_categories = TopicCategory.all
  end

  def set_city
    @city = City.find_by slug: params[:city_id]
  end

  def set_topic
    @topic = Topic.find_by slug: params[:id]
  end

  def set_page
    @page = (params[:page] || "all")

    if @page == "all"
      nil
    elsif logged_in? && @page == "my"
      nil
    elsif TopicCategory.exists?(@page.to_i)
      nil
    else
      redirect_to city_topics_path(@city)
    end
  end

  def number_of_pages(list)
    (list.size / Topic::PER_PAGE.to_f).ceil
  end
end
