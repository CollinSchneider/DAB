var ctrl = angular.module("MainControllerModule",[]);

ctrl.controller('ProductsController', ['$scope', 'ProductsApi',
  function($scope, ProductsApi){

    $scope.products = [];
    $scope.page = 0;
    $scope.limit = 5;

    $scope.loadMore = function(){
      $scope.getProducts();
      $scope.page += 1;
    };

    $scope.getProducts = function(){
      ProductsApi.getAll($scope.page, $scope.limit).then(function(response){
        $scope.products = $scope.products.concat(response.data.products);
      });
    }

    // console.log('doc height: ', $(document).height());
    // console.log('scroll: ', $(document).height());
    if($(window).scrollTop() + $(window).height() >= $(document).height()-200) {
      $scope.loadMore()
    }

    $(window).scroll(function(){
      if($(window).scrollTop() + $(window).height() >= $(document).height()-200) {
        $scope.loadMore()
      }
    })

  }
]);
