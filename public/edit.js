var delete_user = document.getElementById('delete_user');
var confirm_delete = document.getElementById('confirm_delete');
var edit_user_settings = document.getElementById('edit_user_settings');

delete_user.addEventListener('click', function() {
  edit_user_settings.style.filter = 'blur(5px)';
  confirm_delete.style.display = 'block';
})

window.onclick = function(event) {
if (event.target == confirm_delete) {
  edit_user_settings.style.filter = 'none';
  confirm_delete.style.display = 'none';
}
}
