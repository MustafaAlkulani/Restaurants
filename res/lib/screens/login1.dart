import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res/data/providers/userprovider.dart';
import 'package:res/generated/i18n.dart';
import 'package:res/screens/register1.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {

  
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

@override
  void initState() {
 
    super.initState();
    _firebaseMessaging.getToken().then((token) => print('token is '+token));

  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
        title: Text(
          I18n.of(context).login,
        ),
          // backgroundColor: ,
        ),
        body: Builder(
          builder: (context) => Container(
            color: Theme.of(context).accentColor.withOpacity(.5),
            padding: EdgeInsets.all(16),
            height: double.infinity,
            child: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   new BoxShadow(
                      //     color: Colors.black26,
                      //     offset: new Offset(0.0, 2.0),
                      //     blurRadius: 25.0,
                      //   )
                      // ],
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(16),
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                I18n.of(context).login,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(16),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ChangeNotifierProvider<
                                              UserProvider>(
                                          create: (BuildContext context) =>
                                              UserProvider(),
                                          child: SignUp());
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                I18n.of(context).signup,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            I18n.of(context).welcome,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child: TextFormField(
                                  validator: (value) {
                                    if (_email.text.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(fontSize: 18),
                                  decoration: InputDecoration(
                                    hintText: I18n.of(context).email,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                                child: TextFormField(
                                  validator: (value) {
                                    if (_password.text.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _password,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 18),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: I18n.of(context).password,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.orangeAccent)),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(10, 16, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: RaisedButton(
                          color: Colors.pink,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          elevation: 11,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              model.login(
                                _email.text,
                                _password.text,
                              );
                            } else {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                            }
                          },
                          child: Text(
                            I18n.of(context).login,
                            style: TextStyle(
                                fontSize: 30,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: 8),
                        child: Center(
                            child: Text(I18n.of(context).doyouhaveaccount)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
