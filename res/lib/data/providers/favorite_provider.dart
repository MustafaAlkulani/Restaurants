import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:res/data/classes/abstract/query_model.dart';
import 'package:res/data/models/dishmodel.dart';
import 'package:res/util/const.dart';

class FavoriteProvider extends QueryModel {
  @override
  Future loadData([BuildContext context]) {
    return null;
  }

  DishModel dishResponse;
  FavoriteProvider() {
    dishResponse = DishModel();
  }

  Future<void> getFavorite([BuildContext context]) async {
    try {
      dishResponse =
          DishModel.fromJson(await fetchData('${Constants.url}/favorite'));

      print('tmtmtmtmtm');
      finishLoading();
      // notifyListeners();
      return null;
    } on DioError catch (e) {
      print(e.message.toString());
    }
  }

  Future<void> toggleFavoriteStatus(id) async {
    try {
      dishResponse.data[id - 1].isfavor = !dishResponse.data[id - 1].isfavor;

      int fav = dishResponse.data[id - 1].isfavor == true ? 1 : 0;

      await uploadData('${Constants.url}/dish/$id', {'id': id, 'isfavor': fav});

      getFavorite();
      notifyListeners();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      // Something happened in setting up or sending the request that triggered an Error

      print(e.message);
    }
  }
}
