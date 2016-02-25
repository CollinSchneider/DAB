// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var app = angular.module('DealBaked', []);

app.controller('ProductsController', ['$http', '$scope', function($http, $scope){

  getProducts = function(){
    $http.get('/api/products').then(function(response){
      var data = response.data;
      $scope.products = data.products;
    })
  }

  checkCategory = function(){
    if($scope.newProduct.category === 'Apparel'){
      $scope.apparel_quantity = true;
    } else {
      $scope.total_quantity = true;
    }
  }

  $scope.createProduct = function(){
    $http.post('/api/products', {product: $scope.newProduct}).then(function(response){
      $scope.product = response.data;
      checkCategory();
    })
  }

  $scope.createInventory = function(productId){
    $http.put('/api/products/' + productId, {product: $scope.newProduct}).then(function(response){
      console.log(response);
      var data = response.data;
      $scope.product = data.product;
      $scope.newProduct = {};
      getProducts();
    })
  }
  getProducts();

}])
