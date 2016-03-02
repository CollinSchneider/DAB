var ctrl = angular.module("MainControllerModule",[]);

ctrl.controller('ProductsController', ['$scope', 'ProductsApi',
  function($scope, ProductsApi){

    $scope.products = [];
    $scope.page = 0;
    $scope.limit = 10;

    $scope.loadMore = function(){
      ProductsApi.getAll($scope.page, $scope.limit).then(function(response){
        $scope.products = $scope.products.concat(response.data.products);
        console.log($scope.products);
        $scope.page += 1;
      });
    };

    // $scope.loadMore()

    $(window).scroll(function(){
      if($(window).scrollTop() + $(window).height() >= $(document).height()-50) {
          $scope.loadMore()
      }
    })

  }
]);
