import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:res/data/providers/userprovider.dart';
import 'package:res/generated/i18n.dart';
import '../screens/login1.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _c_password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(
    BuildContext context,
  ) {
    final model = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
        title: Text(
          I18n.of(context).register,
        ),
        ),
        body: 
        Builder(
        builder: (context) =>
         Container(
            color: Theme.of(context).accentColor.withOpacity(.5),
            padding: EdgeInsets.all(16),
            height: double.infinity,
            child: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height ,
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
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //       return ChangeNotifierProvider<UserProvider>(
                                //           create: (BuildContext context) =>
                                //               UserProvider(),
                                //           child: MenuDashboardPage());
                                //     },
                                //   ),
                                // );
                              },
                              child: Text(
                                I18n.of(context).signup,
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
                                      return ChangeNotifierProvider<UserProvider>(
                                          create: (BuildContext context) =>
                                              UserProvider(),
                                          child: LoginPage());
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                I18n.of(context).signin,
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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 32, bottom: 8),
                              child: TextFormField(
                                validator: (value) {
                                  if (_name.text.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: _name,
                                style: TextStyle(fontSize: 18),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  hintText: I18n.of(context).notifications,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: Colors.orangeAccent)),
                                ),
                              ),
                            ),
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
                                      borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: Colors.orangeAccent)),
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
                                      borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: Colors.orangeAccent)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: TextFormField(
                                validator: (value) {
                                  if (_c_password.text.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller: _c_password,
                                obscureText: true,
                                style: TextStyle(fontSize: 18),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: I18n.of(context).cpassword,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.grey)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: Colors.orangeAccent)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              model.register(_name.text, _email.text,
                                  _password.text, _c_password.text);

                             
                            } else {
                               Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text(I18n.of(context).result)));
                            }
                          },
                          child: Text(
                            I18n.of(context).signin,
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
                            child: Text('Do you have an account? Login UP')),
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
