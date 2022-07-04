import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerr_mvvm/view/CartPage.dart';
import '../view_model/ProductViewModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var productViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productViewModel = Provider.of<ProductViewModel>(context,listen:false);
    productViewModel.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Consumer<ProductViewModel>(
                  builder: (context,data1,child){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[

                            Icon(Icons.shopping_cart),
                            Text(data1.countCart.toString())

                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
          body: Consumer<ProductViewModel>(builder: (context,data,child){
            return data.isLoading?
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                )
                : ListView.builder(
              itemCount: data.productLists.length,
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(data.productLists[index].image!),
                              fit: BoxFit.cover
                            )
                          ),
                        ),

                        Container(
                          child: Row(
                            children: <Widget>[

                              Expanded(child: Text(data.productLists[index].title!,style: TextStyle(fontSize: 20),)),
                              
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(16)
                                ),
                                  child: Text(data.productLists[index].ratingModel!.rate!.toString(),style: TextStyle(fontSize: 14),)),

                            ],
                          )
                        ),

                        Text("Rs. "+data.productLists[index].price!.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                        data.cartLists.contains(data.productLists[index])
                        ?
                        ElevatedButton(
                            onPressed: (){
                              productViewModel.removeCart(data.productLists[index]);
                            }, child: Text("Added")
                        ):
                        ElevatedButton(
                            onPressed: (){
                              productViewModel.addCart(data.productLists[index]);
                            }, child: Text("Add to cart")
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
