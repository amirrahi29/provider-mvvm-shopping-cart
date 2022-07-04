import 'package:flutter/cupertino.dart';
import 'package:providerr_mvvm/Repository/ProductRepository.dart';
import 'package:providerr_mvvm/model/ProductModel.dart';

class ProductViewModel extends ChangeNotifier{

  var productLists = <ProductModel>[];
  var cartLists = <ProductModel>[];
  var isLoading = true;

  int get countCart => cartLists.length;
  double get totalPrice => cartLists.fold(0, (previousValue, element) => previousValue+element.price!);

  setLoading(bool loading)
  {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> getAllProducts() async{
    var product = await ProductRepository.fetchAllProducts();
    if(product != null){
      productLists = product;
      setLoading(false);
    }
  }
  
  addCart(ProductModel item)
  {
    cartLists.add(item);
    notifyListeners();
  }

  removeCart(ProductModel item)
  {
    cartLists.remove(item);
    notifyListeners();
  }

  clearCart(){
    cartLists.clear();
  }

}