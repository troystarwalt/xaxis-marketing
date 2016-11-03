$('.videos').on 'click', '.platform-play-video', (e)->
  index = $(this).data 'index'
  video = gon.videos[index]
  $('#videoModal #video-embed').html video.embed_link

  $('#videoModal').modal 'show'

  e.preventDefault()
