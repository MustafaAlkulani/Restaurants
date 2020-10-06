import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:res/data/providers/orderProvider.dart';
import 'package:res/data/providers/userprovider.dart';
import 'package:res/generated/i18n.dart';
import 'package:res/screens/login1.dart';
import 'package:res/widgets/cart_item.dart';
import 'package:res/widgets/loaders/color_loader_3.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final TextEditingController _couponlControl = new TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      Provider.of<OrderProvider>(context, listen: false).getTotal();
      
    });

       Future.microtask(() {
      Provider.of<OrderProvider>(context, listen: false).getData();
      
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final total = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          I18n.of(context).checkout,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            tooltip: "Back",
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 130),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  I18n.of(context).shippingAddress,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            ListTile(
              title: Text(
                I18n.of(context).address,
                style: TextStyle(
//                    fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              subtitle: Text("1278 Loving Acres Road Kansas City, MO 64110"),
            ),
            SizedBox(height: 10.0),
            Text(
              I18n.of(context).paymentmethod,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            Card(
              elevation: 4.0,
              child: ListTile(
                title: Text("John Doe"),
                subtitle: Text(
                  "5506 7744 8610 9638",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                leading: Icon(
                  FontAwesomeIcons.creditCard,
                  size: 50.0,
                  color: Theme.of(context).accentColor,
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              I18n.of(context).items,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
                   total.isLoading
                  ? ColorLoader3()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: total.orderResponse.data.length,
                        itemBuilder: (BuildContext context, int index) {

                          return CartItem(
                            img: total.orderResponse.data[index].img,
                            isFav: false,
                            name: total.orderResponse.data[index].name,
                            rating: 5.0.toString(),
                            raters: 23,
                            price: total.orderResponse.data[index].price,
                          );
                        },
                      ),
                    ),
            
          ],
        ),
      ),
      bottomSheet: Card(
        elevation: 4.0,
        child: Container(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.grey[200],
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[200],
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText:I18n.of(context).couponcode,
                      prefixIcon: Icon(
                        Icons.redeem,
                        color: Theme.of(context).accentColor,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                    controller: _couponlControl,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          I18n.of(context).total,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        // Consumer<OrderProvider>(
                        //   builder: (context,model,child)=>
                        Text(
                          // r"$ 212",
                          total.total.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        //  ),

                        Text(
                          "Delivery charges included",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                    width: 150.0,
                    height: 50.0,
                    child: FlatButton(
                      color: Theme.of(context).accentColor,
                      child: Text(
                        I18n.of(context).placeorder.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ChangeNotifierProvider<UserProvider>(
                                  create: (BuildContext context) =>
                                      UserProvider(),
                                  child: LoginPage());
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          height: 130,
        ),
      ),
    );
  }
}
