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


$(window).scroll(function() {
  var url = $('.pagination > a').attr('href');
  if(url && $(window).scrollTop()>$(document).height()-$(window).height()-10){
    $('.pagination').text("Fetching more products...");
    return $.getScript(url);
  }
});

$(document).ready(function() {

  // $('#sign-up-tag').click(function(){
  //   console.log('signup');
  //   $('#signup-content').toggle();
  //   $('#login-content').toggle();
  // })

  function toggleSignUp(){
    $('.ToggleOff').removeClass('ToggleOff')
    $('#login-content').addClass('ToggleOff')
    $('#signup-button').addClass('ToggleOff')
  }

//   function toggleLogIn(){
//     $('.ToggleOff').removeClass('ToggleOff');
//     $('#signup-content').addClass('ToggleOff')
//     $('#login-button').addClass('ToggleOff')
//   }
//
//   $('#sign-up-tag').on('click', function() {
//     toggleSignUp()
//   });
//
//   $('#login-tag').on('click', function() {
//     toggleLogIn()
//   });
});

$(document).ready(function(){
  setTimeout(function(){
    $('.ToggleOff').removeClass('ToggleOff')
    $('#login-content').addClass('ToggleOff')
    $('#signup-button').addClass('ToggleOff')
  }, 2000)
})
