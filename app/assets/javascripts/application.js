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
// = require jquery.infinite-pages
//= require jquery_ujs
//= require turbolinks

// var active = false
//
// function scroller(){
//   $(window).scroll(function() {
//     var url = $('.pagination > a').attr('href');
//     // console.log($(window).scrollTop());
//     if($(window).scrollTop()>$(document).height()-$(window).height()-50){
//       console.log(active);
//       if(!active && url){
//         active = true;
//         $.getScript(url).then(function(){
//           active = false;
//         })
//       }
//     }
//   });
// }
//
//
// $(document).ready(function(){
//   scroller()
// })

//= require Chart
//= require excanvas

if($('.success-div')){
  setTimeout(function(){
    $('.success-div').fadeOut()
  }, 5000)
}

if($('.error-div')){
  setTimeout(function(){
    $('.error-div').fadeOut()
  }, 5000)
}
