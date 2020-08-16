import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res/data/providers/dishProvider.dart';
import 'package:res/generated/i18n.dart';
import 'package:res/screens/details.dart';
import 'package:res/util/const.dart';

import 'package:res/widgets/smooth_star_rating.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final reqeust = Provider.of<DishProvider>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10.0),
          Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                autofocus: false,
                onSubmitted: (text) {
                  if (text != null) {
                    text = text.toLowerCase();
                    reqeust.getsearch(text);
                  }
                },
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: I18n.of(context).search,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              I18n.of(context).history,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // ChangeNotifierProvider(
          //   create: (BuildContext context) => DishProvider(),
          reqeust.dishResponse.data == null
              ? Center(child: Text(I18n.of(context).result))
              : Search(),

          SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Search extends StatefulWidget {
  const Search({
    Key key,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // void initState() {
  //   Future.microtask(() {
  //     Provider.of<DishProvider>(context, listen: false).getsearch('water');
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<DishProvider>(
      builder: (context, model, child) =>
          // model.isLoading?CircularProgressIndicator():
          model.dishResponse.data.length == null
              ? Center(child: Text('No data foud'))
              : ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.dishResponse.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        model.dishResponse.data[index].name,
                        style: TextStyle(
//                    fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage(
                            // "${food['img']}",
                            model.dishResponse.data[index].img),
                      ),
                      trailing: Text(
                          model.dishResponse.data[index].price.toString() +
                              '\$'),
                      subtitle: Row(
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
                            //"5.0 (23 Reviews)",
                            model.dishResponse.data[index].rateing.toString() +
                                'Reviews',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            id: model.dishResponse.data[index].id,
                            name: model.dishResponse.data[index].name,
                            img: model.dishResponse.data[index].img,
                            rataing: model.dishResponse.data[index].rateing,
                            describtion:
                                model.dishResponse.data[index].description,
                            country: model.dishResponse.data[index].country,
                            price: model.dishResponse.data[index].price,
                          ),
                        ));
                      },
                    );
                  },
                ),
    );
  }
}
