window.onload = function() {
  console.log('debug done on load');
  var html = document.getElementsByTagName('html')[0];
  html.setAttribute('contenteditable',true);
}
