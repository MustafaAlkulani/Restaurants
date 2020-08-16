import 'package:flutter/material.dart';

import 'package:res/data/providers/orderProvider.dart';
import 'package:res/generated/i18n.dart';
import 'package:res/screens/checkout.dart';

import 'package:res/widgets/cart_item.dart';
import 'package:provider/provider.dart';
import 'package:res/widgets/loaders/color_loader_2.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with AutomaticKeepAliveClientMixin<CartScreen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<OrderProvider>(context,listen: false).getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context);
    //print(order.orderResponse.data);

    super.build(context);
    return Scaffold(
      body: order.orderResponse==null?Text('no data found'): order.isLoading
          ?Center(child: ColorLoader2(color1: Colors.redAccent,color2: Colors.deepPurple,color3: Colors.green,))
                 
          : order.orderResponse.data == null
         ? Text('No data found ')
         : Padding(
             padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
             child: ListView.builder(
               itemCount:order.orderResponse.data
                       .length, //foods == null ? 0 : foods.length,
               itemBuilder: (BuildContext context, int index) {
                 return ChangeNotifierProvider(
                   create: (ctx) => OrderProvider(),
                   child: CartItem(
                     i:index,
                     id: order.orderResponse.data[index].id,
                     img: order.orderResponse.data[index].img,
                     isFav: true,
                     name: order.orderResponse.data[index].name,
                     rating: order.orderResponse.data[index].rateing,
                     raters: 23,
                     price: order.orderResponse.data[index].price,
                     count: order.orderResponse.data[index].count,
                     describtion:
                         order.orderResponse.data[index].description,
                     country: order.orderResponse.data[index].country,
                     type:order.orderResponse.data[index].type ,
                   ),
                 );
               },
             ),
           ),
      
    
                
      floatingActionButton: FloatingActionButton(
        tooltip: I18n.of(context).checkout,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ChangeNotifierProvider<OrderProvider>(
                  create: (context)=>OrderProvider(),
                  child: Checkout());
              },
            ),
          );
        },
        child: Icon(
          Icons.arrow_forward,
        ),
        heroTag: Object(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
