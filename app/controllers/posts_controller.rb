class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts =  Post.tagged_with(params[:tag])
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
    @posts = Post.all
    @news_posts = Post.tagged_with("News", :match_all => true).last(5)
    @announcement_posts = Post.tagged_with("Announcement", :match_all => true).last(3)
    @event_posts = Post.tagged_with("Event", :match_all => true)
    @event_posts_most_recent = @event_posts[2, 4]
    @tags = ActsAsTaggableOn::Tag.most_used
    @talent_posts = Post.tagged_with("Talent & Culture", :match_all => true)
  end

  def post_params
    params.require(:post).permit(:title, :text, :tag_list, :author)
  end
end
