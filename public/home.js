var modal = document.getElementById('login_modal');
var login_button = document.getElementById('login_button');
var signup_button = document.getElementById('signup_button');

login_button.onclick = function() {
  modal.style.display = "block";
}

window.onclick = function(event) {
if (event.target == modal) {
  modal.style.display = "none";
}
}

signup_button.onclick = function() {
  window.location.href = "/users/new";
}
