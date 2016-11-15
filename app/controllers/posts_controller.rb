class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts =  Post.tagged_with(params[:tag]).paginate(page: params[:page])
    else
      @posts = Post.paginate(page: params[:page])
    end
    @all_tags = Post.tag_counts.pluck(:name)
  end

  def show
    @post = Post.friendly.find(params[:id])
    if Rails.env.development?
      puts "the facebook link will error out in development"
    end
    if request.path != post_path(@post)
      return redirect_to @post, :status => :moved_permanently
    end
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
    @posts = Post.includes(:tags).last(5)
    @initial_post = @posts.first
    @tags = ActsAsTaggableOn::Tag.most_used
    gon.posts = Post.includes(:tags).last(5).map{|post| post.get_main_json}
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :tag_list, :author)
  end
end
