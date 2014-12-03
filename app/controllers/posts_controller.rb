class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_topic, only: [:create, :edit]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = @topic.posts.new(post_params)
    @post.user = current_user
    
    if @post.save
      redirect_to @post.topic, notice: "Successfully created your post."
    else
      render action: :new, error: "An error occurred while trying to create your post."
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post.topic, notice: 'Your post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Your post was successfully deleted.'
  end
  
  protected
  
  def post_params
    params.require(:post).permit(:content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
  
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
  
end
