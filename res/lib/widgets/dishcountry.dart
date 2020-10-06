import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res/data/providers/dishProvider.dart';



class COuntryCategory extends StatefulWidget {
  final String title;
  final String items;
  final Function tap;
  final bool isHome;
  final Color colors;

  COuntryCategory(
      {Key key,
      @required this.colors,
      @required this.title,
      @required this.items,
      this.tap,
      this.isHome,
      String name})
      : super(key: key);

  @override
  _COuntryCategoryState createState() => _COuntryCategoryState();
}

class _COuntryCategoryState extends State<COuntryCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isHome
          ? () {
              Future.microtask(() {
                Provider.of<DishProvider>(context, listen: false)
                    .getCountrydish(widget.title);
              });
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context){
              //       return DishesScreen();
              //     },
              //   ),
              // );
            }
          : widget.tap,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.2,
        height: MediaQuery.of(context).size.width / 2.5,
        child: Card(
          color: widget.colors,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 4.0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              children: <Widget>[
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      "${widget.title}",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),

                    Text(
                      ' ',
                      // "${widget.items} Items",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                    // SizedBox(height: 5),
                  ],
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
