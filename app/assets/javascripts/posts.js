// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('.posts.main').ready(function(){

  var postIndex = 0;
  var current_post = gon.posts[postIndex];
  var cycle_posts = true;
  autoSwap();

  $('.single-news-container').on('click', function(event){
    cycle_posts = false;
    setClickedElementStyles(this);
    setTimeout(function(){
      cycle_posts = true;
    }, 10000);
  });

  function autoSwap(){
    setInterval(function(){
      if(cycle_posts === false){return;}
      var nextPostIndex = postIndex + 1;
      if(nextPostIndex >= gon.posts.length){nextPostIndex = 0;}
      setClickedElementStyles($('.single-news-container')[nextPostIndex]);
      postIndex = nextPostIndex;
    }, 3500);
  }

  function swapSelectedUpdate(post){
    $('#single-news_title').text(post.title);
    $('#single-news_image').attr("src", post.img_url);
    $('#single-news_text').text(post.text);
    $('#single-news_tag_list').text(post.tag_list);
    $('#single-news_date').text(post.date);
    var slug = post.slug || post.id;
    $('#single-news_readmore').attr('href', "/posts/"+slug);
  }

  function setClickedElementStyles(elem){
    if($(elem).hasClass('active')){return;}
    $('.single-news-container').removeClass('active');
    $(elem).addClass('active');
    var postId = $(elem).attr('data-postId');
    gon.posts.find(function(post){
      if(post.id == postId){
        current_post = post;
        postIndex = gon.posts.indexOf(post);
        return swapSelectedUpdate(post);
      }
    });
  }
});
