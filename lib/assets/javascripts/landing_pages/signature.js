//= require jquery
//= require bootstrap.v3.js
//= require shrinking_nav

var supportsPassive = false;
try {
  var opts = Object.defineProperty({}, 'passive', {
    get: function() {
      supportsPassive = true;
    }
  });
  window.addEventListener("test", null, opts);
} catch (e) {}


var form_submit = document.forms["signature_form"]["form_submit_button"]

form_submit.addEventListener("click", formValues, supportsPassive ? { passive: true } : false);

function formValues() {
  var fname = document.forms["signature_form"]["first_name_input"].value,
      lname = document.forms["signature_form"]["last_name_input"].value,
      jtitle = document.forms["signature_form"]["title_input"].value,
      ophone = document.forms["signature_form"]["office_num_input"].value,
      mphone = document.forms["signature_form"]["mobile_num_input"].value;

  var f_name = document.getElementById("first_name"),
      l_name = document.getElementById("last_name"),
      j_title = document.getElementById("job_title"),
      o_phone = document.getElementById("sig_office_phone"),
      m_phone = document.getElementById("sig_mobile_phone");
  f_name.innerHTML = fname;
  l_name.innerHTML = lname;
  j_title.innerHTML = jtitle;
  o_phone.innerHTML = ophone;
  m_phone.innerHTML = mphone;
  return false;
}

$('.field-input').on('focus', function() {
  $(this).keyup(function(e) {
    var targetId = $(this).data("target");
    var targetedText = document.getElementById(targetId);
    console.log(e.currentTarget.value + e.currentTarget.id + " " + targetedText.parentElement);
    if (e.currentTarget.value != '') {
    targetedText.parentElement.style.display = "inherit";
    targetedText.innerHTML = e.currentTarget.value
      if (targetedText == document.getElementById("sig_email")) {
        var href_element = targetedText.parentElement;
        var href_value = href_element.getAttribute('href');
        console.log("same shit");
        console.log(href_value);
        href_element.href = "mailto:" + e.currentTarget.value;
      }
    }
    else {
      targetedText.parentElement.style.display = "none";
    }
  });
})
