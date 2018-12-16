var modal = document.getElementById('login_modal');
var login_button = document.getElementById('login_button');
var signup_button = document.getElementById('signup_button');
var grid = document.getElementById('grid');

login_button.onclick = function() {
  modal.style.display = 'block';
  grid.style.filter = 'blur(5px)';
}

window.onclick = function(event) {
if (event.target == modal) {
  grid.style.filter = 'none';
  modal.style.display = "none";
}
}

signup_button.onclick = function() {
  window.location.href = "/users/new";
}
