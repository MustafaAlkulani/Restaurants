import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:res/data/providers/app_provider.dart';
// import 'package:res/data/providers/favorite_provider.dart';
// import 'package:res/data/providers/orderProvider.dart';
import 'package:res/data/providers/userprovider.dart';
import 'package:res/generated/i18n.dart';
import 'package:res/screens/details.dart';
import 'package:res/screens/splash.dart';
import 'package:res/util/const.dart';

import 'data/providers/dishProvider.dart';
import 'util/const.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(
          create: (context) => DishProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => OrderProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
        //      ChangeNotifierProvider(
        //   create: (context) => FavoriteProvider(),

        // ), //      ChangeNotifierProvider(
        //   create: (context) => FavoriteProvider(),

        // ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //  void initState() {
  //   // Future.microtask(() {

  //   //   Provider.of<DishProvider>(context, listen: false).getData();
  //   // });
  //   // super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(

            key: appProvider.key,
            debugShowCheckedModeBanner: false,
            navigatorKey: appProvider.navigatorKey,
            title: Constants.appName,
            theme: appProvider.theme,
            darkTheme: Constants.darkTheme,
          
            localizationsDelegates: [
              I18n.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: Locale('ar'),
            supportedLocales: I18n.delegate.supportedLocales,
            home: SplashScreen(),
            routes: {
              // ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              ProductDetails.routeName: (ctx) => ProductDetails(),
            });
      },
    );
  }
}

// void main() {
//   runApp(MyTempApp());
// }

// class MyTempApp extends StatefulWidget {
//   @override
//   _MyTempAppState createState() => _MyTempAppState();
// }

// class _MyTempAppState extends State<MyTempApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MultiProvider(
//         providers: [
//           ChangeNotifierProvider.value(
//             value: TempProvider(),
//           ),
//         ],
//         child: Temp(),
//       ),
//     );
//   }
// }

// providers: [
//   ChangeNotifierProvider.value(
//     value: Products(),
//   ),
//   ChangeNotifierProvider.value(
//     value: Cart(),
//   ),
//   ChangeNotifierProvider.value(
//     value: Orders(),
//   ),
// ],

// class Temp extends StatefulWidget {
//   @override
//   _TempState createState() => _TempState();
// }

// // class _TempState extends State<Temp> {
//   @override
//   void initState() {
//     Future.microtask(() {
//       Provider.of<TempProvider>(context, listen: false).getData();
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var model = Provider.of<TempProvider>(context);
//     return Scaffold(
//         appBar: AppBar(),
//         body: model.isLoading
//             ? Center(child: CircularProgressIndicator())
//             :ListView.builder(
//               itemCount: model.dishResponse.data.length,
//               itemBuilder: (context,index){
//               print(index.toString());
//               return Text(model.dishResponse.data[index].name.toString()??"_");
//             })); //Text(model.dishResponse.toJson().toString()));
//   }
// }
