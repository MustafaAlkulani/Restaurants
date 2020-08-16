import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res/data/providers/dishProvider.dart';
import 'package:res/generated/i18n.dart';

import 'package:res/screens/notifications.dart';
import 'package:res/util/comments.dart';
import 'package:res/util/const.dart';
// import 'package:res/util/foods.dart';
import 'package:res/widgets/badge.dart';
import 'package:res/widgets/smooth_star_rating.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product-detail';
  final int id;
  final String img;
  final String name;
  final int rataing;
  final String describtion;
  final int price;
  final String country;
  final int type;

  const ProductDetails(
      {Key key,
      this.id,
      this.type,
      this.img,
      this.name,
      this.rataing,
      this.describtion,
      this.price,
      this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model=Provider.of<DishProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          I18n.of(context).details,
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications,
              size: 22.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Notifications();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                            icon: Icon(Icons.favorite), onPressed: null)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  SmoothStarRating(
                    starCount: 5,
                    color: Constants.ratingBG,
                    allowHalfRating: true,
                    rating: 5.0,
                    size: 10.0,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "5.0 (23 Reviews)",
                    // rataing.toString(),
                    style: TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
                  Text(
                    //  "20 Pieces",
                    country,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    // r"$90",
                    price.toString(),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
             I18n.of(context).description,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.0),
            Text(
              describtion+
              "''",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Reviews",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 20.0),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments == null ? 0 : comments.length,
              itemBuilder: (BuildContext context, int index) {
                Map comment = comments[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage(
                      "${comment['img']}",
                    ),
                  ),
                  title: Text("${comment['name']}"),
                  subtitle: Column(
                    children: <Widget>[
                      // Row(
                      //   children: <Widget>[
                      //     SmoothStarRating(
                      //       starCount: 5,
                      //       color: Constants.ratingBG,
                      //       allowHalfRating: true,
                      //       rating: 5.0,
                      //       size: 12.0,
                      //     ),
                      //     SizedBox(width: 6.0),
                      //     Text(
                      //       "February 14, 2020",
                      //       style: TextStyle(
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w300,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                     
                      SizedBox(height: 7.0),
                      Text(
                        "${comment["comment"]}",
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: RaisedButton(
          child: Text(
            "ADD TO CART",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            
                        model.addtocart(
                          id,
                            
                            name,
                            country,
                            price,
                            rataing,
                            img,
                            describtion,
                            type
                            ) ;
            
          },
        ),
      ),
    );
  }
}
