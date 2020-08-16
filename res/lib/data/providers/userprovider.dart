import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:res/data/classes/abstract/query_model.dart';
import 'package:res/data/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends QueryModel{

  User userResponse=User();
  String name='';

  @override
  Future loadData([BuildContext context]) {
    
   return null;
  }


  Future getData([BuildContext context]) async {
    if (1 == 1) {
      var user = await fetchData('http://192.168.1.14:8000/api/user');

      //print(orders);
      userResponse = User.fromJson(user);
      print(userResponse.toString());

      finishLoading();
    }
    
    finishLoading();
    return null;
  }
  Future getuserData([BuildContext context]) async {
    if (1 == 1) {
      var user = await SharedPreferences.getInstance();

      name=user.getString('name');
      
      print(name);

    }
    
 
    return null;
  }


//     final stringValue='';
//  void  getStringValuesSF() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //Return String
//    stringValue = prefs.getString('name');
 
// }
// final pref=  getStringValuesSF();



  Future login(String email,String password) async {
   try {
      // print('fffffffffffffffffffffff');
      var user = await login_query('http://192.168.1.14:8000/api/login',{
        'email':email,
        'password':password,

      }
      
      );
      
      print(user.data.toString());

   
    }on DioError catch(e){
      print(e.message.toString());
    }
    
 
    return null;
  }

Future<void> register(  String name,String email,String password,String c_password) async {
  try{
    print('iam here');
      var user = await register_qury('http://192.168.1.14:8000/api/register',{
        'name':name,
        'email':email,
        'password':password,
        'c_password':c_password,

      }
      
      );
   var pref=await SharedPreferences.getInstance();

   print(user.data.toString());
 pref.setString('token','Bearer  '+ user.data['data']['token']);
 print(user.data['data']['name']);

 pref.setString('name', user.data['data']['name']);

  //  print(user.data['data']['token'].toString());
//  print( pref.getString('name'));
    
   

    print('done');

   
   
  }on DioError catch(e){
    if(e.type==DioErrorType.DEFAULT){}
    else if(e.type==DioErrorType.RESPONSE){}

    else if(e.type==DioErrorType.SEND_TIMEOUT)
    // else if(e.type==DioErrorType.)

 
        print(e.message);
  }
    
  
  }


}



