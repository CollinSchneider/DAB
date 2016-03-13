// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

<<<<<<< HEAD

$(document).ready(function() {
  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url = $('.pagination .next_page').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
        $('.pagination').text("Please Wait...");
        return $.getScript(url);
      }
    });
    return $(window).scroll();
=======
// if($('.pagination').length) {
  // console.log('start')
  $(window).scroll(function() {
    var url = $('.pagination > a').attr('href');
    if(url && $(window).scrollTop()>$(document).height()-$(window).height()-10){
      $('.pagination').text("Fetching more products...");
      return $.getScript(url);
    }
  });
// }
>>>>>>> 4c0387f610026c0c29c966f36514c5bb13b5bb7e
