
var fd = new FormData();
fd.append('quote', document.getSelection().focusNode.textContent);
fd.append('source_url', document.location.href);

var url = "http://localhost:4567/";
var http = new XMLHttpRequest();
http.open("POST", url, true);

http.onreadystatechange = function() {
    if(http.readyState == 4 && http.status == 200) {
        alert(http.responseText);
    }
}

http.send(fd);
