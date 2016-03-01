// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// var init = function(){


$('select').material_select();


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

    //Contains the filter options
    $scope.filterOptions = {
      stores: [
        {id : 2, name : 'Show All', category: "all" },
        {id : 3, name : 'Tech', category: "Tech" },
        {id : 4, name : 'Apparel', category: "Apparel" },
        {id : 5, name : 'Gadgets', category: "Gadgets" },
        {id : 6, name : 'Essentials', category: "Essentials" },
        {id : 7, name : 'Accessories', category: "Accessories" },
        {id : 8, name: 'Art/Culture', category: "Art/Culture"}
      ]
    };

    //Contains the sorting options
    $scope.sortOptions = {
      stores: [
        {id : 1, name : 'Price Highest to Lowest' },
        {id : 2, name : 'Price Lowest to Highest' },
        ]
    };

    //Mapped to the model to filter
    $scope.filterItem = {
      store: $scope.filterOptions.stores[0]
    }

    //Mapped to the model to sort
    $scope.sortItem = {
      store: $scope.sortOptions.stores[0]
    };

    //Watch the sorting model - when it changes, change the
    //ordering of the sort (descending / ascending)
    $scope.$watch('sortItem', function () {
      console.log($scope.sortItem);
      if ($scope.sortItem.store.id === 1) {
        $scope.reverse = true;
      } else {
        $scope.reverse = false;
      }
    }, true);

    //Custom filter - filter based on the category selected
    $scope.customFilter = function (data) {
      if (data.category === $scope.filterItem.store.category) {
        return true;
      } else if ($scope.filterItem.store.category === "all") {
        return true;
      } else {
        return false;
      }
    };

}])
