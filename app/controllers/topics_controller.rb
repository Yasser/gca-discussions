class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  
  def index
    @topics = Topic.all
  end

  def show
    @post = Post.new(topic_id: @topic.id)
  end
  
  def new
    @topic = Topic.new
    @topic.posts.build(user_id: current_user.uid)
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
        
    if @topic.save
      redirect_to @topic, notice: "Successfully created your topic thread."
    else
      render action: :new, error: "An error occurred while trying to create your topic thread."
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to @topic, notice: 'Your topic was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_url, notice: 'Your topic and all associated posts were successfully deleted.'
  end
  
  protected
  
  def set_topic
    @topic = Topic.find(params[:id])
  end
  
  def topic_params
    params.require(:topic).permit(:title, posts_attributes: [:content, :user_id])
  end
end
