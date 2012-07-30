
window.onload = function() {
  var form = document.getElementById('authForm');
  form.onsubmit = function(e) {
    var login = document.getElementById('loginField').value;
    var pass  = document.getElementById('passField').value;
    auth(login, pass);

    return false;
  }
}

function auth(login, pass) {
  var http = new XMLHttpRequest();

  var fd = new FormData();
  fd.append('user[login]', login);
  fd.append('user[password]', pass);

  http.open("POST", 'http://reckoning.me/auth?callback=data', true);

  http.onreadystatechange = function() {
      if(http.readyState == 4 && http.status == 200) {
        if (http.responseText == "auth ok") {
          window.location.reload();
        }
      } else {
      }
  }

  http.send(fd);
}
