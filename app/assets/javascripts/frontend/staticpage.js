function removeHash () { 
  history.pushState("", document.title, window.location.pathname + window.location.search);
}

$( document ).ready(function() {

	$('.top-nav').onePageNav({
    currentClass: 'current',
    changeHash: false,
    scrollSpeed: 800,
    scrollThreshold: 0.5,
    filter: ':not(.external)',
    easing: 'swing',
    begin: function() {
      removeHash();

    },
    end: function() {
      $('.navbar-collapse').removeClass('in');

      

    },
    scrollChange: function($currentListItem) {

   
    }

  });
});









