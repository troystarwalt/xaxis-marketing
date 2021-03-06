# frozen_string_literal: true
class PostsController < ApplicationController
  helper_method :sort_button, :sort_direction

  def index
    if params[:tag]
      @posts =  Post.published.tagged_with(params[:tag]).paginate(page: params[:page])
    else
      @posts = Post.published.paginate(page: params[:page]).order(sort_button + ' ' + sort_direction)
    end
    @all_tags = Post.tag_counts.pluck(:name)
  end

  def show
    @post = Post.published.friendly.find(params[:id])  # get the post from the params

    @next_posts = @post.next
    @previous_posts = @post.previous

    @all_tags = Post.tag_counts.pluck(:name)
    if Rails.env.development?
      puts 'the facebook link will error out in development'
    end
    if request.path != post_path(@post)
      return redirect_to @post, :status => :moved_permanently
    end
  end

  def main
    # gon.latest_post = @latest_post
    # Learning section
    @last_expert = ExpertInterview.last_three
    # posts for the recent news section
    @posts = Post.includes(:tags).published.order("published_at DESC").first(5)
    @latest_post = @posts.first
    @tags = ActsAsTaggableOn::Tag.most_used
    posts = @posts.map{|post| post.get_main_json}
    posts.each do |x|
      x.update(x) do |key, value|
        if key == :text || key == :title
          ActionController::Base.helpers.strip_tags(value)
        else
          value = value
        end
      end
    end
    gon.posts = posts
  end

  private

  def sort_button
    Post.column_names.include?(params[:sort]) ? params[:sort] : "published_at"
  end

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : "desc"
  end
end
