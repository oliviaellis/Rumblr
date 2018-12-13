function signup() {
  let signupform = document.getElementById('signup-form');
  let loginform = document.getElementById('login-form');
  if (signupform.style.height == '300px') {
    signupform.style.height = '0';
  } else {
    signupform.style.height = '300px'
  }
  loginform.style.height = '0';
}

function login() {
  let signupform = document.getElementById('signup-form');
  let loginform = document.getElementById('login-form');
  if (loginform.style.height == '300px') {
    loginform.style.height = '0';
  } else {
    loginform.style.height = '300px'
  }
  signupform.style.height = '0';
}

var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("article");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
  }
  x[slideIndex-1].style.display = "block";
}

function edit_user() {
  window.location.href = '/users/:id/edit';
}
