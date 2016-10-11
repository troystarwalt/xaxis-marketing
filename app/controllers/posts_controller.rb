class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts =  Post.tagged_with(params[:tag])
      byebug
    else
      @posts = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.js { render 'posts/create' }
        format.html { redirect_to root_path }
      else
        format.js { render 'posts/new' }
        format.html { render 'posts/new' }
        puts @post.errors.messages
      end
    end
  end

  def destroy
  end

  def main
    @posts = Post.includes(:tags).all
    @news_posts = @posts.tagged_by("News").last(5)
    @announcement_posts = @posts.tagged_by("Announcement").last(3)
    @event_posts = @posts.tagged_by("Event").last(5)
    @event_posts_most_recent = @event_posts[2, 4]
    @talent_posts = @posts.tagged_by("Talent & Culture").last(3)

    @tags = ActsAsTaggableOn::Tag.most_used

  end

  def post_params
    params.require(:post).permit(:title, :text, :tag_list, :author)
  end
end
