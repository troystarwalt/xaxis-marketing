$(document).ready(function(){
  $('.platform-play-video').on('click', function (e){
    var index = $(this).data('index');
    var video = gon.videos[index];
    $('#videoModal #video-embed').html(video.embed_link);
    $('#videoModal').modal('show');
    e.preventDefault();
  });

  $('#videoModal').on('hide.bs.modal', function(e){
    $('#videoModal #video-embed').html('');
  })
});
