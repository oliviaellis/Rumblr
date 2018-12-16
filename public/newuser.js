var select_icon = document.getElementById('select_icon');
var icon_input = document.getElementById('profile_icon');
var color_input = document.getElementById('profile_color');
var signup_form = document.getElementById('signup_form');
var color_picker = document.getElementById('color_picker');
var image = document.createElement('img');
image.style.backgroundColor = 'white';

function select_image(character) {
  select_icon.style.display = 'none';
  image.src = '/images/profile_icons/' + character + '.png';
  image.id = 'icon';
  color_picker.appendChild(image);
  color_picker.style.visibility = 'visible';
  icon_input.value = character;
}

function create_user() {
  console.log(image.style.backgroundColor);
  color_input.value = image.style.backgroundColor;
  color_picker.style.filter = 'blur(5px)';
  let button = color_picker.querySelector('button');
  button.style.display = 'none';
  signup_form.style.visibility = 'visible';
}
