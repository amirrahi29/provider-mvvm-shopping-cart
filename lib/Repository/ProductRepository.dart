import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:providerr_mvvm/model/ProductModel.dart';

class ProductRepository{

  static var client = http.Client();

  static Future<List<ProductModel>?> fetchAllProducts() async{


    var response = await client.get(Uri.parse("https://fakestoreapi.com/products"));
    if(response.statusCode == 200)
      {
        var convertedJsonData = jsonDecode(response.body);

        // List<ProductModel> productList = [];
        // for(var u in convertedJsonData){
        //   ProductModel productModel = ProductModel.fromJson(u);
        //   productList.add(productModel);
        // }
        // return productList;
        return (convertedJsonData as List).map((e) => ProductModel.fromJson(e)).toList();
      }
    else
      {
        return null;
      }

  }

}