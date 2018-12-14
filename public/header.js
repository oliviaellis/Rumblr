var time = document.getElementById('time');
console.log("Linked");

function get_time() {
  let date = new Date();
  let hours_24 = date.getHours();
  let hours = ((hours_24 + 11) % 12 + 1);
  let mins = date.getMinutes().toString();
  if (mins.length == 1) {
    var minutes = "0" + mins;
  }
  else {
    var minutes = mins;
  }
  if (hours_24 >= 12) {
    var suffix = "PM";
  } else {
    var suffix = "AM";
  }
  let current_time = hours + ":" + minutes + suffix;
  time.innerHTML = current_time;
}
