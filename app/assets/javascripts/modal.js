// $(document).ready(function(){
//   // Using gon variables for image modals
//   $('.single-event-photo').on('click', function (e){
//     var index = $(this).data('index');
//     var photo = gon.photos[index];
//
//     $('.event-photos').attr({
//       src: photo.image.medium.url,
//       alt: photo.title
//       });
//     $('.event-photos').data('photoId', photo.id);
//     $('#eventPhotos').modal('show');
//     e.preventDefault();
//   });
//   // Clearing out the image from the modal on hide/close
//   $('#eventPhotos').on('hidden.bs.modal', function(e){
//     $('.event-photos').attr('src', '');
//   });
// });


var activate_modal = function (click_item, modal_image_class, model_id) {
  // Using gon variables for image modals
  $(click_item).on('click', function (e){
    var index = $(this).data('index');
    var photo = gon.photos[index];

    $(modal_image_class).attr({
      src: photo.image.medium.url,
      alt: photo.title
      });
    $(modal_image_class).data('photoId', photo.id);
    $(model_id).modal('show');
    e.preventDefault();
  });
  // Clearing out the image from the modal on hide/close
  $(model_id).on('hidden.bs.modal', function(e){
    $(modal_image_class).attr('src', '');
    });
});
