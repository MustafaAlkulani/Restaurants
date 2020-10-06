import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:res/data/classes/abstract/query_model.dart';

import 'package:res/data/models/orderModel.dart';
import 'package:res/util/const.dart';

class OrderProvider extends QueryModel {
  @override
  Future loadData([BuildContext context]) async {
   
    return null;
  }

  int counter, total = 0;
  OrderModel orderResponse;
  // int get count{
  //   return counter;
  // }
  OrderProvider() {
    orderResponse = OrderModel();
    counter = 0;
//
  }
 int  count=0;

  Future getData([BuildContext context]) async {
    try {
      if (1 == 1) {
        var orders = await fetchData('${Constants.url}/order');

        orderResponse = OrderModel.fromJson(orders);
     
        
        count=orderResponse.data.length;

       for(int i=1;i<orderResponse.data.length;i++){
        
         items.addAll(orderResponse.data);
         
        }


        finishLoading();
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }


   
  Future<void> getNewData([BuildContext context]) async {
    try {
      if (1 == 1) {
        var orders = await fetchData('${Constants.url}/order');

        orderResponse = OrderModel.fromJson(orders);
        
        // count=orderResponse.data.length;
        print(orderResponse.data[1]);
              //  final List rawdata=decode((bytes);
        //  List<OrderModel> list= orders.map((f)=>orderResponse as Map);

        finishLoading();
      }
    } on DioError catch (e) {
      print(e.error);
    }
  }


  Future<void> increase(int count, int id) async {
    try {
      // if (count >= 0) counter = count + 1;
      counter=count;
      print(counter.toString());
      print(count.toString());

      await uploadData('${Constants.url}/order/increase', {
        'id': id,
        'count': counter,
      });
      //  print(count.toString());
      notifyListeners();
      return null;
    } on DioError catch (e) {
      print(e.message);
    }
  }

  ////////////////////////
  ///

  Future<void> deletorder(int id) async {
    try {
      await deletdata('${Constants.url}/order/delete/$id');

       count=orderResponse.data.length;
         //_items.remove(productId);
        for(int i=1;i<orderResponse.data.length;i++){
         if(orderResponse.data[i].id==id)
         {
          
          print(i);
         }
        }
        // List<Map> list=orderResponse.data[]
          getNewData();
     
     

      print(id.toString() + 'delete');
       notifyListeners();
    } on DioError catch (e) {
      print(e.message);
    }
  }
  ////////////////////////////////////

  Future<void> decrease(int count, int id) async {
    // if (counter>=0)

    counter = count;

    await uploadData('${Constants.url}/order/decrease',
        {'id': id, 'count': count});
    notifyListeners();
    return null;
  }

/////////////////////////
  ///
  ///
  Future<void> getTotal() async {
    var orders = await fetchData('${Constants.url}/order');

    //print(orders);
    total = 0;
    orderResponse = OrderModel.fromJson(orders);

    for (int i = 0; i < orderResponse.data.length; i++) {
      total += orderResponse.data[i].price * orderResponse.data[i].count;
    }

    notifyListeners();
    return total;
  }
  // void set getcountorder(){

  // }
   

  // void set getcountorder(length){
  //   count=orderResponse.data.length == null ? 0 : orderResponse.data.length;
  // }

  int get getcountorder {
    return count;
  }

  int get counters {
    return counter;
  }






  Future<void> addtocart(int id, String name, String country, int price,
      int rating, String img, String describtion, int type) async {

    try {

       print('id.toString()hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    
      await uploadData('${Constants.url}/order/add',
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
      count=orderResponse.data.length+1;
      print('done');
   
      getData();
         notifyListeners();
    } on DioError catch (e) {


     
      print(e.message);
    }
  }


  //   Future<void> getcountorder() async {
  //      var orders = await fetchData('http://192.168.1.14:8000/api/order');

  //     //print(orders);
  //     int countorder=0;
  //     orderResponse = OrderModel.fromJson(orders);

  //     for(int i=0;i<orderResponse.data.length;i++)
  //     {
  //      total+=orderResponse.data[i].price*orderResponse.data[i].count;
  //     }

  //   notifyListeners();
  //   return total;
  // }

}
////////////////////////////////////////////
///
///
///

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:res/data/classes/abstract/query_model.dart';
// import 'package:res/data/models/temp.dart';

// class TempProvider extends QueryModel {
//   DishModel dishResponse;
//   TempProvider() {
//     dishResponse = DishModel();
//   }
//   Future getData([BuildContext context]) async {
//     if (1 == 1) {
//       var dishes = await fetchData('http://192.168.1.14:8000/api/dish');
//       dishResponse = DishModel.fromJson(dishes);
//       finishLoading();
//     }
//     finishLoading();
//     return null;
//   }

//   @override
//   Future loadData([BuildContext context]) async {
//     return null;
//   }
// }
