// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('.posts.main').ready(function(){

  $('.single-news-container').on('click', function(){
    if($(this).hasClass('active')){return;}
    var $that = $(this);
    $('.single-news-container').removeClass('active');
    $(this).addClass('active');
    var postId = $(this).attr('data-postId');
    gon.posts.find(function(post){
      if(post.id == postId){
        return swapSelectedUpdate(post);
      }
    });
  });

});

function swapSelectedUpdate(post){
  $('#single-news_title').text(post.title);
  $('#single-news_image').attr("src", post.image_url);
  $('#single-news_text').text(post.text);
  $('#single-news_tag_list').text(post.tag_list);
  $('#single-news_date').text(post.date);
  var slug = post.id;
  if(post.slug != null){
    slug = post.id;
  }
  $('#single-news_readmore').attr('href', "/posts/"+slug);
}
