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

    // $scope.getTech = function(tech){
    //   ProdutsApi.getCategory(tech).then(function(response){
    //     $scope.techProducts;
    //   })
    // }
    //
    // $scope.getApparel = function(apparel){
    //   ProdutsApi.getCategory(apparel).then(function(response){
    //     $scope.apparelProducts;
    //   })
    // }
    //
    // $scope.getEssentials = function(essentials){
    //   ProdutsApi.getCategory(essentials).then(function(response){
    //     $scope.essentialsProducts;
    //   })
    // }
    //
    // $scope.getArt_Culture = function(art_culture){
    //   ProdutsApi.getCategory(art_culture).then(function(response){
    //     $scope.art_cultureProducts;
    //   })
    // }
    //
    // $scope.getAccesories = function(accessories){
    //   ProdutsApi.getCategory(accessories).then(function(response){
    //     $scope.accessoriesProducts;
    //   })
    // }
    //
    // $scope.getGadgets = function(gadgets){
    //   ProdutsApi.getCategory(gadgets).then(function(response){
    //     $scope.gadgetsProducts;
    //   })
    // }

    $scope.scrollLoad = function(){
      if($(window).scrollTop() + $(window).height() >= $(document).height()-200) {
        $scope.loadMore()
      }
    }

    $scope.scrollLoad();

    $(window).scroll(function(){
      $scope.scrollLoad()
  })

  }
]);
