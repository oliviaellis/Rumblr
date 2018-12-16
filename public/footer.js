console.log('Footer.js linked');
var footer_list = document.getElementById('button_controls');
var user_articles = document.getElementById('user_articles');
console.log(user_articles);

if (user_articles != null) {
  console.log('Found articles');
  let li = document.createElement('li');
  li.innerHTML = '<i class="fas fa-caret-left"></i>   <i class="fas fa-caret-right"></i>';
  let text = document.createTextNode(' Browse Articles');
  li.appendChild(text);
  footer_list.appendChild(li);
}
