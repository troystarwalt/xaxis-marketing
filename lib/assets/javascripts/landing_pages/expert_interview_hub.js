//= require jquery
//= require bootstrap.v3.js

$('.landing_pages .expert_interview_hub').ready(function(){
  $('#myModal').on('show.bs.modal', function (event) {
    var a = $(event.relatedTarget);
    var videoUrl = a.data('video-url');
    var videoTitle = a.data('title');

    var modal = $(this);
    modal.find('.modal-header .modal-title').text(videoTitle);
    modal.find('.modal-body iframe').attr("src", videoUrl);
  });

  $('#myModal').on('hide.bs.modal', function(event){
    $('iframe').attr('src', '');
  });

  $(window).on('load', function(){
    setHeights('.small-card-body');
  });
  $(window).on('resize', function(){
    setHeights('.small-card-body');
  });
});

function setHeights(elems){
  $(elems).each(function() {
    $(this).height('');
  });
  var maxHeight = -1;
  $(elems).each(function() {
    maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
  });

  $(elems).each(function() {
    $(this).height(maxHeight);
  });
}
