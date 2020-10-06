import 'package:flutter/material.dart';


import 'package:res/screens/details.dart';
import 'package:res/util/const.dart';
import 'package:res/widgets/smooth_star_rating.dart';

class SliderItem extends StatelessWidget {
  final int id;
  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final String describtion,country;
  final int price;

  SliderItem(
      {Key key,
      @required this.id,
      @required this.name,
      @required this.img,
       @required this.describtion,
      @required this.price,
      @required this.country,
      @required this.isFav,
      @required this.rating,
      @required this.raters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Consumer<Dish>(
    //   builder: (BuildContext context, dish, Widget child,)  =>
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width,
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
                    child: Text(
                      '$rating\$',
                      style: TextStyle(color: Colors.red),
                    ),
                    // Icon(
                    //   isFav ? Icons.favorite : Icons.favorite_border,
                    //   color: Colors.red,
                    //   size: 17,
                    // ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(bottom: 2.0, top: .0),
                      child: Text(
                        ' $name',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    ],
                                        
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                    child: Row(
                      children: <Widget>[
                        SmoothStarRating(
                          starCount: 5,
                          color: Constants.ratingBG,
                          allowHalfRating: true,
                          rating: rating,
                          size: 10.0,
                        ),
                        Text(
                          " $rating ($raters Reviews)",
                          style: TextStyle(
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
         MaterialPageRoute(builder: (context)=>ProductDetails(
           id: id,
           name: name,
           img:img,
           rataing: rating.toInt(),
          describtion: name,
          country: name,

         ),)
        //  ProductDetails.routeName,
        //  arguments:id,

          );
      }
      );
      
    
  }
}

