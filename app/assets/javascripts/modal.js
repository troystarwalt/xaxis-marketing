$(document).ready(function(){
  // Using gon variables for image modals
  $('.single-event-photo').on('click', function (e){
    var index = $(this).data('index');
    var photo = gon.photos[index];

    $('.event-photos').attr({
      src: photo.image.medium.url,
      alt: photo.title
      });
    $('.event-photos').data('photoId', photo.id);
    $('#eventPhotos').modal('show');
    e.preventDefault();
  });
  // Clearing out the image from the modal on hide/close
  $('#eventPhotos').on('hidden.bs.modal', function(e){
    $('.event-photos').attr('src', '');
  });
});


// var $grid = $('.photo-grid').masonry({
//   itemSelector: '.photo-grid-item',
//   percentPosition: true,
//   columnWidth: 330
// });
// // layout Isotope after each image loads
// $grid.imagesLoaded().progress( function() {
//   console.log("loading...")
//   $grid.masonry();
// });

$('.photo-grid').masonry({
  itemSelector: '.photo-grid-item',
  columnWidth: '.photo-grid-sizer',
  percentPosition: true,
});
