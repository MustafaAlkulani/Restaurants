import 'package:flutter/material.dart';

import 'package:res/data/providers/dishProvider.dart';
import 'package:res/data/providers/favorite_provider.dart';
import 'package:res/screens/details.dart';
import 'package:res/util/const.dart';
import 'package:res/widgets/smooth_star_rating.dart';
import 'package:provider/provider.dart';

class GridProduct extends StatelessWidget {
  final int id;
  final String name;
  final String img;
  final bool isFav;
  final int rating;
  final int raters;
  final String describtion;
  final String country;
  final int price;
  final int type;

  GridProduct(
      {Key key,
      this.type,
      this.id,
      this.name,
      this.img,
      this.describtion,
      this.price,
      this.country,
      this.isFav,
      this.rating,
      this.raters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DishProvider>(
        builder: (BuildContext context, model, Widget child) => 
         InkWell(
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 3.6,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              '$img',
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
                              child: Consumer<FavoriteProvider>(
                                builder: (BuildContext context,
                                        FavoriteProvider fav, Widget child) =>
                                    IconButton(
                                  icon: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                  ),
                                  color: Colors.red,
                                  onPressed: () {
                                    fav.toggleFavoriteStatus(id);
                                    Future.microtask(() => Provider.of<FavoriteProvider>(context,listen: false).getFavorite());

                                    
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        //  MainAxisAlignment:MainAxisAlignment.spaceBetween,
                           
                        Expanded(
                          flex: 2,
                          child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 2.0,
                                  top: 5.0,
                                ),
                                child: Text(
                                  "$name",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                                child: Row(
                                  children: <Widget>[
                                    SmoothStarRating(
                                      starCount: 5,
                                      color: Constants.ratingBG,
                                      allowHalfRating: true,
                                      rating: rating.toDouble(),
                                      size: 10.0,
                                    ),
                                    Text(
                                      " $rating ($raters \$)",
                                      style: TextStyle(
                                        fontSize: 11.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 2.0, top: 8.0, right: 2.0),
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.shopping_cart,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => 
                                   
                                      model.addtocart(
                                       id,
                                          
                                          name,
                                          country,
                                          price,
                                          rating,
                                          img,
                                          describtion,
                                          type
                                          ) 
                                          )
                                          ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                onTap: () {
                  // Navigator.of(context).pushNamed(
                  //   ProductDetails.routeName,
                  //   arguments: id,
                  // );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProductDetails(
                          id: id,
                          name: name,
                          img: img,
                          describtion: describtion,
                          price: price.toInt(),
                          country: country,
                        );
                      },
                    ),
                  );
                },
              ));
  }
}
