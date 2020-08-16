import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:res/data/providers/favorite_provider.dart';
import 'package:res/generated/i18n.dart';
import 'package:res/widgets/grid_pro_favorite.dart';


import 'package:res/widgets/loaders/color_loader_2.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin<FavoriteScreen> {
  void initState() {
    Future.microtask(() {
      Provider.of<FavoriteProvider>(context,listen: false).getFavorite();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              I18n.of(context).favorite,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),
            Consumer<FavoriteProvider>(
              builder: (context, model, child) => model.isLoading
                  ? Center(child: ColorLoader2(color1: Colors.redAccent,color2: Colors.deepPurple,color3: Colors.green,))
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
                        return GridProduct(
                         
                          id:model.dishResponse.data[index].id ,
                          img: model.dishResponse.data[index].img,
                          isFav: model.dishResponse.data[index].isfavor,
                          name: model.dishResponse.data[index].name,
                          rating: model.dishResponse.data[index].rateing,
                          raters: 23,
                          country:model.dishResponse.data[index].country ,
                          describtion: model.dishResponse.data[index].description,
                          price: model.dishResponse.data[index].price,
                               type: model.dishResponse.data[index].type ,
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
