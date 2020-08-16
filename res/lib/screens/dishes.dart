import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res/data/providers/app_provider.dart';
import 'package:res/data/providers/dishProvider.dart';
import 'package:res/generated/i18n.dart';
import 'package:res/screens/notifications.dart';
import 'package:res/widgets/badge.dart';
import 'package:res/widgets/dishcountry.dart';
import 'package:res/widgets/grid_product.dart';

class DishesScreen extends StatefulWidget {
  final List<Color> colors = [
    Colors.blue,
    Colors.pink,
    Colors.cyan,
    Colors.orange,
    Colors.blue,
    Colors.pink,
    Colors.white30,
    Colors.orange
  ];
  @override
  _DishesScreenState createState() => _DishesScreenState();
}
   String countname = 'oman';
class _DishesScreenState extends State<DishesScreen> {
  void initState() {
    Future.microtask(() {
      Provider.of<DishProvider>(context, listen: false).getCountry();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
 

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
           I18n.of(context).dishes,
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
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: ListView(children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                  height: 70,
                  color: Theme.of(context).primaryColor,
                  child: Consumer<DishProvider>(
                    builder: (context, model, child) => model.isLoading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.dishResponse.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return COuntryCategory(
                                colors: widget.colors[index],
                                name: model.dishResponse.data[index].country,
                                items: '20',
                                title: model.dishResponse.data[index].country,
                                isHome: false,
                                tap: () {
                                
                                    Provider.of<DishProvider>(context,
                                            listen: false)
                                        .getCountrydish(model
                                            .dishResponse.data[index].country);
                                  

                                  setState(() {
                                    countname =
                                        model.dishResponse.data[index].country;
                                  });
                                },
                              );
                            }),
                  )),
              SizedBox(height: 15.0),
              Text(
                "$countname",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Divider(),
              SizedBox(height: 10.0),
              
              Countryinfo(countryname: 'yemen'),
            ])));
  }
}

class Countryinfo extends StatefulWidget {
  final countryname;
  const Countryinfo({this.countryname});

  @override
  _CountryinfoState createState() => _CountryinfoState();
}

class _CountryinfoState extends State<Countryinfo> {
  void initState() {
    // Future.microtask(() {
    //   Provider.of<DishProvider>(context, listen: false).getCountrydish(widget.countryname);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DishProvider>(
      builder: (context, model, child) => model.dishcountry.data==null

          ? CircularProgressIndicator()
                                  
          : GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: model.dishcountry.data.length==null?0: model.dishcountry.data.length,
              itemBuilder: (BuildContext context, int index) {
                // Map food = foods[index];
                return GridProduct(
                  id: model.dishcountry.data[index].id,
                  img: model.dishcountry.data[index].img,
                  isFav: model.dishcountry.data[index].isfavor,
                  name: Provider.of<AppProvider>(context).locale == 'ar'
                              ? model.dishResponse.data[index].name_ar
                              : model.dishResponse.data[index].name,
                  rating: model.dishcountry.data[index].rateing,
                  raters: model.dishcountry.data[index].price,
                  describtion: model.dishcountry.data[index].description,
                  country: model.dishcountry.data[index].country,
                  price: model.dishcountry.data[index].price,
                  type: model.dishcountry.data[index].type,
                );
              },
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
   //model.dispose();
  }
}
