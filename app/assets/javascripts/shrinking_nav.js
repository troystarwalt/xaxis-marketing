function init() {
  window.addEventListener('scroll', function(e) {
    var distanceY = window.pageYOffset || document.documentElement.scrollTop,
        shrink_on = 150,
        body_element = document.querySelector("body");
    if (distanceY > shrink_on) {
      body_element.classList.add('shrnk');
    } else {
      if (body_element.classList.contains('shrnk')) {
        body_element.classList.toggle('shrnk');
      }
    }
  });
}

window.onload = init();
