
//var body = document.getElementsByTagName('BODY')[0];
//if(body && body.readyState == 'loaded') {
//    init();
//} else {
//    if (window.addEventListener) {  
//        window.addEventListener('load', init, false);
//    } else {
//        window.attachEvent('onload', init);
//    }
//}
//
//function init() {
//  var f = document.getElementById('linkToQuote');
//  f.focus();
//  f.select();
//}
//l = console.log;

window.onload = function() {
  window.addEventListener('message', handler, false);
}

function handler(e) {
  console.log('got data', e.data);
}
