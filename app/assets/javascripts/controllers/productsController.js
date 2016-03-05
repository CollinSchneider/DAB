var ctrl = angular.module("MainControllerModule",[]);

ctrl.controller('ProductsController', ['$scope', 'ProductsApi',
  function($scope, ProductsApi){

    $scope.products = [];
    $scope.page = 0;
    $scope.limit = 3;

    $scope.loadMore = function(){
      $scope.getProducts();
      $scope.page += 1;
    };

    $scope.getProducts = function(){
      ProductsApi.getAll($scope.page, $scope.limit).then(function(response){
        $scope.products = $scope.products.concat(response.data.products);
      });
    }

    $scope.deleteProduct = function(productId){
      ProductsApi.deleteProduct(productId).then(function(response){
        $scope.getProducts();
      })
    }

    $scope.scrollLoad = function(){
      if($(window).scrollTop() + $(window).height() >= $(document).height()-200) {
        $scope.loadMore()
      }
    }

    $scope.scrollLoad()

    $(window).scroll(function(){
      $scope.scrollLoad()
  })

  }
]);
