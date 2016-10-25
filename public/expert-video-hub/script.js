
$(document).ready(function(){
  videoList = [];
  initVideoList();
  currentlyPlaying = 0;

    $(document).on('click',"#myModal", function(){
       $('iframe').attr('src','');
    }).on('click','.modal-content',function(e) {
        e.stopPropagation();
   });

});

function setBoxHeights(){
    $('.box').height('auto');
    var maxheight = 0;
      $('.box').each(function () {
          maxheight = ($(this).height() > maxheight ? $(this).height() : maxheight);
       });
      $('.box').height(maxheight);
}

function initVideoList(){
  var videos = $('.vid-selector');
  for(var i = 0; i < videos.length; i++){
    var videoId = $(videos[i]).attr('src');
    videoList.push({videoId: videoId});
  }
}

function onPlayerReady(event) {
  event.target.playVideo();
}

function stopVideo() {
  player.stopVideo();
}

function setVimeoVideo(vidId){
  var video = videoList[vidId - 1];
  videoId = video.videoId;
  var iframe = document.getElementsByTagName('iframe')[0];
  iframe.setAttribute('src',video.videoId);
  currentlyPlaying = vidId;
}

function nextVideo(){
    if (currentlyPlaying == videoList.length){
        setVimeoVideo(1);
    }
    else{
        setVimeoVideo(currentlyPlaying+1);
    }
}

function previousVideo(){
    if(currentlyPlaying == 1)
        setVimeoVideo(videoList.length);
    else{
        setVimeoVideo(currentlyPlaying-1);
    }
}
