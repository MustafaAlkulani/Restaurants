import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res/data/providers/dishProvider.dart';
import 'package:res/generated/i18n.dart';
import 'package:res/screens/notifications.dart';
import 'package:res/util/categories.dart';

import 'package:res/widgets/badge.dart';
import 'package:res/widgets/grid_product.dart';
import 'package:res/widgets/home_category.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
    String catie;
  void initState() {
    Future.microtask(() {
       catie = I18n.of(context).drinks;
      Provider.of<DishProvider>(context, listen: false).getCategory(1);
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
          I18n.of(context).category,
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
            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null ? 0 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];
                  return HomeCategory(
                    id: cat['index'],
                    icon: cat['icon'],
                    title: cat['name'],
                    items: cat['items'].toString(),
                    isHome: false,
                    tap: () {
                      Future.microtask(() {
                        Provider.of<DishProvider>(context, listen: false)
                            .getCategory(index+1);
                      });

                      setState(() {
                         catie = "${cat['name']}";
                      });
                        
                      
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "$catie",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            Divider(),
            SizedBox(height: 10.0),
            Consumer<DishProvider>(
              builder: (context, model, child) => model.isLoading
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
                      itemCount: model.dishResponse.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Map food = foods[index];
                        return GridProduct(
                          id: model.dishResponse.data[index].id,
                          img: model.dishResponse.data[index].img,
                          isFav: model.dishResponse.data[index].isfavor,
                          name: model.dishResponse.data[index].name,
                          rating: model.dishResponse.data[index].rateing,
                          raters: model.dishResponse.data[index].price,
                          describtion:
                              model.dishResponse.data[index].description,
                          country: model.dishResponse.data[index].country,
                          price: model.dishResponse.data[index].price,
                           type: model.dishResponse.data[index].type ,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
