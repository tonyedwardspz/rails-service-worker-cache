$(document).ready(function(){
  installCacheServiceWorker();
});

function installCacheServiceWorker(){
  'use strict';

  console.log('Service worker started');
  // Check that service workers are available
  if ('serviceWorker' in navigator) {
  	console.log('navigator available');
    navigator.serviceWorker.register('/serviceWorker.js').then(function(reg) {

      console.log('ServiceWorker registration successful with scope: ', reg.scope);

    }).catch(function(err) {
      console.log('ServiceWorker registration failed: ', err);
    });
  }
}
