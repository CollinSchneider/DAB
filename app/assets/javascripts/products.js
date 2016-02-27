// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

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

window.onload = function(){
  init();
}
