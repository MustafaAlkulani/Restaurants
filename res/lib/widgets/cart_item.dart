import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res/data/providers/orderProvider.dart';
import 'package:res/screens/details.dart';
import 'package:res/util/const.dart';
import 'package:res/widgets/smooth_star_rating.dart';

class CartItem extends StatefulWidget {
  final int i;
  final int id;
  final String name;
  final String img;
  final bool isFav;
  final String rating;
  final int raters;
  final int count;
  final int price;
  final int type;
  final String describtion, country;

  CartItem(
      {Key key,
      this.id,
      this.i,
      this.describtion,
      this.country,
      this.type,
      @required this.name,
      @required this.img,
      @required this.isFav,
      @required this.rating,
      @required this.raters,
      this.count,
      this.price})
      : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final del = Provider.of<OrderProvider>(context, listen: false);
    int counter=widget.count;
    return Dismissible(
        key: Key('value'),
        onDismissed: (DismissDirection direction) {
          del.deletorder(widget.id);
         del.orderResponse.data.removeAt((widget.i) );
          Future.microtask(() => Provider.of<OrderProvider>(context,listen: false).getNewData());

        },
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
        ),
        child:

            // final models=Provider.of<OrderProvider>(context);
            Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProductDetails(
                        id: widget.id,
                        name: widget.name,
                        img: widget.img,
                        describtion: widget.describtion,
                        country: widget.country,
                       type: 1,
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 5.0),
                child: Card(
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                       // color: Colors.white70,
                        // color: Colors.white.withOpacity(.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Container(
                            height: MediaQuery.of(context).size.width / 3.5,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                "${widget.img}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "${widget.name}",
                              style: TextStyle(
                                
                               fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                SmoothStarRating(
                                  starCount: 1,
                                  color: Constants.ratingBG,
                                  allowHalfRating: true,
                                  rating: 5.0,
                                  size: 12.0,
                                ),
                                SizedBox(width: 6.0),
                                Text(
                                  "${widget.rating}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                // Text(
                                //   "$count : peaces",
                                //   style: TextStyle(
                                //     fontSize: 11.0,
                                //     fontWeight: FontWeight.w300,
                                //   ),
                                // ),
                                SizedBox(width: 10.0),
                                Text(
                                  "price: ${widget.price}\$",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              "Quantity: 1",
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40.0,
                        ),
                        widget.isFav
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 5.0, 0.0, 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Consumer<OrderProvider>(
                                          builder: (context, model, child) =>
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colors.red,
                                                    size: 30.0,
                                                  ),
                                                  onPressed: ()  {
                                                       counter=counter+1;
                                                   model.increase(
                                                          counter,
                                                          widget.id);
                                                       
                                                          
                                                  }
                                                      
                                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        RawMaterialButton(
                                          onPressed: () {},
                                          fillColor: Theme.of(context).primaryColor,
                                          shape: CircleBorder(),
                                          elevation: 4.0,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Consumer<OrderProvider>(
                                              builder: (BuildContext context,
                                                      model, Widget child) =>
                                                  Text(counter.toString()),

                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Consumer<OrderProvider>(
                                          builder: (context, model, child) =>
                                              IconButton(
                                            icon: Icon(Icons.minimize,
                                                color: Colors.red, size: 30.0),
                                            onPressed: () {
                                              counter=counter-1;
                                              model.decrease(
                                                counter, widget.id);
                                                
                                                
                                                }
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : SizedBox(
                                width: 3.0,
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
