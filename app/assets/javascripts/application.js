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
//= require_tree .

var init = function(){

var app = angular.module('DealBaked', []);

app.controller('ProductsController', ['$scope', '$http', function($scope, $http){

  $http.get('/api/products').then(function(response){
    var data = response.data;
    $scope.products = data.products;
  })

  $scope.checkCategory = function(){
    console.log($scope.newProduct.category);
    if($scope.newProduct.category === 'Apparel'){
      $scope.apparel_quantity = true
      $scope.total_quantity = false;
    } else {
      $scope.total_quantity = true;
      $scope.apparel_quantity = false;
    }
  }

  $scope.createProduct = function(){
    $http.post('/api/products', {product: $scope.newProduct}).then(function(response){
      console.log(response.data);
    })
  }

}])

};
 init();
