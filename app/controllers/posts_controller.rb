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
    @posts = Post.includes(:tags).last(5)
    @tags = ActsAsTaggableOn::Tag.most_used
    gon.posts = Post.includes(:tags).last(5).map{|post| post.get_main_json}
  end

  def post_params
    params.require(:post).permit(:title, :text, :tag_list, :author)
  end
end
