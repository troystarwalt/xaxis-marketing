var slideUl = document.getElementById('slides');
var slides = document.querySelectorAll('#slides .slide'); // Grab all he slides
var currentSlide = 0;

slideUl.style.height = "300px";  // Set container height with JS

for(var i=0; i<slides.length; i++) {
  slides[i].style.position = 'absolute'; // Loop through each slide, and set abs.
  if (i > 0) {
    slides[i].style.opacity = "0";
  }
}

var controls = document.querySelectorAll('.controls');
for(var i=0; i<controls.length; i++){
  controls[i].style.display = 'inline-block'; // Show the controls.
}

function nextSlide() {
  goToSlide(currentSlide+1);  // Send the current slide + 1
}

function previousSlide() {
  console.log(currentSlide - 1);
  goToSlide(currentSlide-1); // Send the current slide -1
}

function goToSlide(n) {
  slides[currentSlide].className = 'slide';
  slides[currentSlide].style.opacity = "0";  // Update the opacity.
  currentSlide = (n+slides.length)%slides.length;
  slides[currentSlide].className = 'slide showing';
  slides[currentSlide].style.opacity = "1";  // Hey we'd like to see you.
}

var next = document.getElementById('next');
var previous = document.getElementById('previous');

next.onclick = function() {
  nextSlide();
};

previous.onclick = function() {
  previousSlide();
};
