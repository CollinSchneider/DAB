// var api = angular.module('ProductsApiFactory', []);
//
// api.factory('ProductsApi', ['$http', function($http){
//
//   var productsFactoryInterface = {};
//   var baseUrl = '/api/products';
//
//   productsFactoryInterface.getAll = function(page, limit){
//     page = page || 0;
//     limit = limit || 5;
//     var url = baseUrl + "?page=" + page + "&limit=" + limit;
//     return $http.get(url);
//   };
//
//   // productsFactoryInterface.getCategory = function(category){
//   //   var url = baseUrl + '?category=' + category;
//   //   return $http.get(url)
//   // }
//
//   productsFactoryInterface.deleteProduct = function(productId){
//     var url = baseUrl + '/' + productId;
//     return $http.delete(url);
//   }
//
//   return productsFactoryInterface;
//
// }]);
