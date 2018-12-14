var delete_user = document.getElementById('delete_user');
var confirm_delete = document.getElementById('confirm_delete');
console.log(confirm_delete);

delete_user.addEventListener('click', function() {
  confirm_delete.style.display = 'block';
})
