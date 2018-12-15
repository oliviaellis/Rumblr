console.log('Footer.js linked');
var footer_list = document.getElementById('button_controls');
var user_articles = document.getElementById('user_articles');
console.log(user_articles);

if (user_articles != null) {
  console.log('Found articles');
  let li = document.createElement('li');
  let text = document.createTextNode('Arrows - Browse Articles');
  li.appendChild(text);
  footer_list.appendChild(li);
}
