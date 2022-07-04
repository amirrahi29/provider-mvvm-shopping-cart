import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerr_mvvm/view_model/ProductViewModel.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var productViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productViewModel = Provider.of<ProductViewModel>(context,listen:false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Consumer<ProductViewModel>(builder: (context,data1,child){
              return Row(
                children: <Widget>[

                  Expanded(child: Text("My Cart (${data1.countCart.toString()})")),
                  Text("Total Price: "+data1.totalPrice.toString()),

                ],
              );
            })
          ),
          body: Consumer<ProductViewModel>(builder: (context,data,child){
            return ListView.builder(
                itemCount: productViewModel.cartLists.length,
                itemBuilder: (count,index){
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[

                        Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image: NetworkImage(data.cartLists[index].image!),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),

                        Expanded(child: Text(data.cartLists[index].title!+"/n"+data.cartLists[index].price.toString())),

                        InkWell(
                          onTap: (){
                            productViewModel.removeCart(data.cartLists[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.close,color: Colors.red,),
                          ),
                        )

                      ],
                    ),
                  );
                }
            );
          })
        )
    );
  }
}
