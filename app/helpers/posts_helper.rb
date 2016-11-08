module PostsHelper
  def get_post_text(post)
    truncate(post.text, length: 200)
  end
end
