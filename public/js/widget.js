var head = document.getElementsByTagName('head')[0],
    script  = document.createElement('script'),
    script1 = document.createElement('script');

script.src = "http://reckoning.me/js/rangy-core.js";
script.onload = function() {
  rangy.init();
}

head.appendChild(script);

if (! (document.location.host == "reckoning.me")) {
  sendPage();
}

function renderLoginBox(id) {
    var url = 'http://reckoning.me/iframe?id='+id,
        box   = "<iframe id='QuotesSpaceIFrame' width='100%' height='100%' src="+url+"></iframe>";

    createDivs(box);
}


window.addEventListener('mouseup', function() {
  var iframe   = document.getElementById('QuotesSpaceIFrame'),
      anchorId = Math.round( Math.random() * 100000 ),
      sel = rangy.getSelection(),
      //sel = document.getSelection(),
      data = {
        selection: rangy.serializeSelection(),
      };

    highlightText(sel, sel.getRangeAt(0));
    iframe.contentWindow.postMessage(data, '*');

    sel.removeAllRanges();
});

function sendPage() {
    var data = {
        source_url: document.location.href,
        host:  document.location.host,
        title: document.getElementsByTagName('title')[0].innerHTML,
        html:  document.getElementsByTagName('html')[0].innerHTML
    };

    var url = "http://reckoning.me/";
    var http = new XMLHttpRequest();
    http.open("POST", url, true);

    http.onreadystatechange = function() {
        if (http.readyState == 4 && http.status == 200) {
           renderLoginBox(http.responseText);
        }
    }

    http.setRequestHeader('Content-type', 'application/json');
    http.send(JSON.stringify(data));
}


function createDivs(html) {
    var div = document.createElement('div');
    div.style.opacity = '5';
    div.style.background = 'white'; 
    div.style.width = '100%'; 
    div.style.height = '10%'; 
    div.style['z-index'] = 10000;
    div.style.top = 0; 
    div.style.left = 0; 
    div.style.position = 'fixed';
    div.innerHTML = html;

    if (document.body.firstChild) {
        document.body.insertBefore(div, document.body.firstChild);
    } else {
        document.body.appendChild(div);
    }
}

function highlightText(selection, range) { 
  document.designMode = "on";
  if (range) {
    selection.removeAllRanges();
    selection.addRange(range);
  }

  var colour = '#F5ED7F';
  // Use HiliteColor since some browsers apply BackColor to the whole block
  if ( !document.execCommand("HiliteColor", false, colour) ) {
    document.execCommand("BackColor", false, colour);
  }
  document.designMode = "off";
}
