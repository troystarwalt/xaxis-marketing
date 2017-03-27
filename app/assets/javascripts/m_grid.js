// Sort images only after they are loaded.
var $grid = $('.photo-grid').masonry({
  itemSelector: '.photo-grid-item',
  percentPosition: true,
  columnWidth: '.photo-grid-sizer'
});
// layout Isotope after each image loads
$grid.imagesLoaded().progress( function() {
  $grid.masonry();
});

// Another way to control the photos.
// $('.photo-grid').masonry({
//   itemSelector: '.photo-grid-item',
//   columnWidth: '.photo-grid-sizer',
//   percentPosition: true,
// });
