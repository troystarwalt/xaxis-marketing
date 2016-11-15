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
    collect_resources
    @posts = Post.includes(:tags).last(5)
    @initial_post = @posts.first
    @tags = ActsAsTaggableOn::Tag.most_used
    gon.posts = Post.includes(:tags).last(5).map{|post| post.get_main_json}
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :tag_list, :author)
  end

    def get_most_recent_item(returned_item)
      @whats_happening = returned_item
    end

    def collect_resources
      x = [
      BrandAccessory.order("created_at").last,
      CaseStudy.order("created_at").last,
      Logo.order("created_at").last,
      Infographic.order("created_at").last,
      Video.order("created_at").last,
      Headshot.order("created_at").last,
    ]
    this_is_it = x.flatten.sort_by{ |this| this.created_at}

    find_out_what_class_it_is(this_is_it)
    get_most_recent_item(@single)

    end

    def find_out_what_class_it_is(info)
      single = info.last
      if single.class.name == "CaseStudy"
        return @single = single
      else
        puts "dinosaur"
      end
    end
end
