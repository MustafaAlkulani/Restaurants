import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res/data/providers/app_provider.dart';

import 'package:res/data/providers/dishProvider.dart';
import 'package:res/generated/i18n.dart';
import 'package:res/screens/dishes.dart';
import 'package:res/widgets/grid_product.dart';
import 'package:res/widgets/home_category.dart';
import 'package:res/widgets/loaders/color_loader_2.dart';
import 'package:res/widgets/slider_item.dart';

import 'package:res/util/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  void initState() {
    Future.microtask(() {
      Provider.of<DishProvider>(context, listen: false).getData();
    });
    super.initState();
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  I18n.of(context).dishes,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                FlatButton(
                  child: Text(
                    I18n.of(context).more,
                    style: TextStyle(
                      //                      fontSize: 22,
                      //                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DishesScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10.0),

            //Slider Here

            Consumer<DishProvider>(
              builder: (BuildContext context, DishProvider model,
                      Widget child) =>
                  model.isLoading
                      ? Center(
                          child: ColorLoader2(
                          color1: Colors.redAccent,
                          color2: Colors.deepPurple,
                          color3: Colors.green,
                        ))
                      : CarouselSlider(
                          height: MediaQuery.of(context).size.height / 2.4,
                          items: map<Widget>(
                            model.dishResponse.data,
                            (index, i) {
                              // Map food = model.dishResponse.data[index].;
                              // return ChangeNotifierProvider<DishProvider>(
                              //   create: (ctx) => DishProvider(),
                              return model.isLoading
                                  ? Center(
                                      child: ColorLoader2(
                                      color1: Colors.redAccent,
                                      color2: Colors.deepPurple,
                                      color3: Colors.green,
                                    ))
                                  : SliderItem(
                                      id: model.dishResponse.data[index].id,
                                      img: model.dishResponse.data[index].img,
                                      isFav: model
                                          .dishResponse.data[index].isfavor,
                                      name: Provider.of<AppProvider>(context)
                                                  .locale ==
                                              'ar'
                                          ? model
                                              .dishResponse.data[index].name
                                          : model.dishResponse.data[index].name_ar,
                                      rating: model
                                          .dishResponse.data[index].rateing
                                          .toDouble(),
                                      raters:
                                          model.dishResponse.data[index].price,
                                      price:
                                          model.dishResponse.data[index].price,
                                      describtion: model
                                          .dishResponse.data[index].description,
                                      country: model
                                          .dishResponse.data[index].country,
                                    );
                            },
                          ).toList(),
                          autoPlay: true,
                          //                enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          //              aspectRatio: 2.0,
                          onPageChanged: (index) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
            ),

            SizedBox(height: 20.0),

            Text(
              I18n.of(context).dishes,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),

            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null ? 0 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];
                  return HomeCategory(
                    id: cat[index],
                    icon: cat['icon'],
                    title: cat['name'],
                    items: cat['items'].toString(),
                    isHome: true,
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  I18n.of(context).popular,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                FlatButton(
                  child: Text(
                    I18n.of(context).more,
                    style: TextStyle(
                      //                      fontSize: 22,
                      //                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10.0),

            //  ChangeNotifierProvider(
            //     create:(context) => DishProvider(),
            //     //final dish=Provider.of(context);
            Consumer<DishProvider>(
              builder: (context, model, child) => model.isLoading
                  ? Center(
                      child: ColorLoader2(
                      color1: Colors.redAccent,
                      color2: Colors.deepPurple,
                      color3: Colors.green,
                    ))
                  : GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.25),
                      ),
                      itemCount: model.dishResponse.data
                          .length, //foods == null ? 0 :foods.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GridProduct(
                          id: model.dishResponse.data[index].id,
                          img: model.dishResponse.data[index].img,
                          isFav: model.dishResponse.data[index].isfavor,
                          name: Provider.of<AppProvider>(context).locale =='en'
                              ? model.dishResponse.data[index].name
                              : model.dishResponse.data[index].name_ar,
                          rating: model.dishResponse.data[index].rateing,
                          raters: model.dishResponse.data[index].price,
                          describtion:
                              model.dishResponse.data[index].description,
                          country: model.dishResponse.data[index].country,
                          price: model.dishResponse.data[index].price,
                          type: model.dishResponse.data[index].type,
                        );
                      },
                    ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
