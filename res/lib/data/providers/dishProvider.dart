import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:res/data/classes/abstract/query_model.dart';
import 'package:res/data/models/dishmodel.dart';

// import 'package:res/util/url.dart';

class DishProvider extends QueryModel {
  @override
  Future loadData([BuildContext context]) {
    return null;
  }


  DishModel dishResponse, dishcountry;
  DishProvider() {
    dishResponse = DishModel();
    dishcountry=DishModel();
   
//
  }

  // Future fetchData1(String url, {Map<String, dynamic> parameters}) async {
  //   final response = await Dio().get(url, queryParameters: parameters);

  //   return response.data;
  // }

  Future getData([BuildContext context]) async {
    if (1 == 1) {
      var dishes = await fetchData('http://192.168.1.14:8000/api/dish');
      // var dishes = await fetchData('http://localhost/api/dish');

      dishResponse = DishModel.fromJson(dishes);

      finishLoading();
    }
    finishLoading();
    return null;
  }



  Future getDishes([BuildContext context]) async {
    if (1 == 1) {
      dishResponse = DishModel.fromJson(
          await fetchData('http://192.168.1.14:8000/api/dish'));
    }
    finishLoading();
    return null;
  }

  // Future getFavorite([BuildContext context]) async {
  //   if (1 == 1) {
  //     dishResponse = DishModel.fromJson(
  //         await fetchData('http://192.168.1.14:8000/api/favorite'));
  //   }
  
  
  //   finishLoading();
  //     // notifyListeners();
  //   return null;
  // }

  Future<void> toggleFavoriteStatus(id) async {
    try {
      dishResponse.data[id - 1].isfavor = !dishResponse.data[id - 1].isfavor;
      int fav = dishResponse.data[id - 1].isfavor == true ? 1 : 0;
    
      await uploadData('http://192.168.1.14:8000/api/dish/$id',
          {'id': id, 'isfavor': fav});
       
     getData();
       notifyListeners();
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      // Something happened in setting up or sending the request that triggered an Error
     
      print(e.message);
    }
  }


  Future<void> getsearch(text) async {
    try {

   dishResponse = DishModel.fromJson(
          await fetchData('http://192.168.1.14:8000/api/dish/search/$text'));
    
    finishLoading();
    
     return null;
  

    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      // Something happened in setting up or sending the request that triggered an Error

      print(e.message);
    }
  }


  Future<void> getCategory(id) async {
    try {

   dishResponse = DishModel.fromJson(
          await fetchData('http://192.168.1.14:8000/api/dish/cat/$id'));
    
    finishLoading();
    
     return null;
  
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      // Something happened in setting up or sending the request that triggered an Error

      print(e.message);
    }
  }


  
  Future<void> getCountry() async {

    try {

   dishResponse = DishModel.fromJson(
          await fetchData('http://192.168.1.14:8000/api/dish/country'));
    
    finishLoading();
    
     return null;
  

    } on DioError catch (e) {

      print(e.message);
    }
  }
    Future<void> getCountrydish(name) async {

    try {

   dishcountry = DishModel.fromJson(
          await fetchData('http://192.168.1.14:8000/api/dish/country/$name'));
    
    finishLoading();
    
     return null;
  

    } on DioError catch (e) {

      print(e.message);
    }
  }
  


  Future<void> addtocart(int id, String name, String country, int price,
      int rating, String img, String describtion, int type) async {

    try {
       print('id.toString()hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    
        
      await uploadData('http://192.168.1.14:8000/api/order/add',
       {
        'name': name,
        'img': img,
        'type': type,
        'count':0,
        'description': describtion,
         'country': country,
        'price': price,
        'rateing': rating,
      });


      print('done');
    

      notifyListeners();
    } on DioError catch (e) {


     
      print(e.message);
    }
  }


  
}

