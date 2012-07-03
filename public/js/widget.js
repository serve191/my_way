//auth();
renderLoginBox();

function renderLoginBox() {

    var box = "<iframe id='arivoPage' width='100%' height='100%' src='http://test.couchapp:4567/window'></iframe>";
    createDivs(box);

    
    //var login = document.getElementById('arivoLoginButton');
    //login.onclick = function() {
    //    var login = document.getElementById('arivoLoginLogin').value;
    //    var pass = document.getElementById('arivoLoginPass').value;
    //    auth(login, pass);
   // }
}

//function sendData() {
//    var fd = new FormData();
//    fd.append('quote', document.getSelection().focusNode.textContent);
//    fd.append('source_url', document.location.href);
//
//    var url = "http://localhost:4567/";
//    var http = new XMLHttpRequest();
//    http.open("POST", url, true);
//
//    http.onreadystatechange = function() {
//        if(http.readyState == 4 && http.status == 200) {
//            alert(http.responseText);
//        }
//    }
//
//    http.send(fd);
//}

function auth(login, pass) {
  var http = new XMLHttpRequest();
  if (http.withCredentials !== undefined) {
    console.log('withCredentials');
  }

  var fd = new FormData();
  fd.append('user[login]', login);
  fd.append('user[pass]', pass);

  http.open("POST", 'http://localhost:4567/auth', true);

  http.onreadystatechange = function() {
      //if(http.readyState == 4 && http.status == 200) {
          alert(http.responseText);
      //} else {
      //}
  }

  http.send(fd);
}

function createDivs(html) {
    var div = document.createElement('div');
    div.style.opacity = '0.5';
    div.style.background = '000'; 
    div.style.width = '100%'; 
    div.style.height = '20%'; 
    div.style['z-index'] = 100;
    div.style.top = 0; 
    div.style.left = 0; 
    div.style.position = 'fixed';

    var container = document.createElement('div');
    div.innerHTML = html;
    div.id = 'arivoLogin';
    container.id = 'form_container';
    if (document.body.firstChild){
        document.body.insertBefore(div, document.body.firstChild);
        document.body.insertBefore(container, document.body.firstChild);
    } else {
        document.body.appendChild(div);
        document.body.appendChild(container);
    }
}
