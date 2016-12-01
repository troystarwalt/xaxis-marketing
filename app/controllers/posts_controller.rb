# frozen_string_literal: true
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
      puts 'the facebook link will error out in development'
    end
    if request.path != post_path(@post)
      return redirect_to @post, :status => :moved_permanently
    end
  end

  def main
  # There is a SQL query in post.rb that is more effecient...
    views = {OneSheeter.name => 'box_onesheeter',
            CaseStudy.name => 'box_casestudy',
            Infographic.name => 'box_infographic',
            Video.name => 'box_video'}
    latest_model = collect_latest_resource
    four_latest_models = collect_last_four_resources

    @view_this_box = views[latest_model.class.name]  # This is what tells the view to render a specific box.
    @most_recent_update = latest_model

    @four_most_recent_updates = four_latest_models

    @posts = Post.includes(:tags).last(5)
    @latest_post = Post.last
    @initial_post = @posts.first
    @tags = ActsAsTaggableOn::Tag.most_used
    gon.posts = Post.includes(:tags).last(5).map{|post| post.get_main_json}

  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :tag_list, :author)
  end

  def collect_latest_resource
    # Set which models we want to feature.
    models = [OneSheeter, CaseStudy, Infographic, Video]
    # Create an empty array to store the models that have records.
    models_with_data = []
    # Map over each of the models and put those that have data into the clean array.
    models.map { |q| if q.any? then models_with_data << q end }
    # Take those models_with_data and order them all by created_at.
    latest_models = models_with_data.map { |x| x.order('created_at').last  }
    sorted_models = latest_models.sort_by{ |x| x.created_at }
    sorted_models.last
  end

  def collect_last_four_resources
    # Set which models we want to feature.
    models = [OneSheeter, CaseStudy, Infographic, Video]
    # Create an empty array to store the models that have records.
    models_with_data = []
    # Map over each of the models and put those that have data into the clean array.
    models.map { |q| if q.any? then models_with_data << q end }
    # Take those models_with_data and order them all by created_at.
    latest_models = models_with_data.map { |x| x.order('created_at').last  }
    sorted_models = latest_models.sort_by{ |x| x.created_at }
    sorted_models.last(4)
  end
end
