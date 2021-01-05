import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uberClone/brand_colors.dart';
import 'package:uberClone/screens/mainPage.dart';
import 'package:uberClone/screens/registrationPage.dart';
import 'package:uberClone/widgets/TaxiOutlineButton.dart';
import 'package:uberClone/widgets/progressIndicator.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void showSnakbar(String title) {
    final snackBar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void login() async {
    // show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(status: "Loging You in"),
    );
    final User user = (await _auth
            .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
            .catchError((ex) {
      Navigator.pop(context);
      FirebaseAuthException thisEx = ex;
      thisEx.code == 'user-not-found'
          ? showSnakbar('User Not Found!')
          : thisEx.code == 'wrong-password'
              ? showSnakbar('Wrong Password !')
              : showSnakbar('Something went wrong plaease try again');
    }))
        .user;
    if (user != null) {
      //verify login

      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');
      userRef.once().then((DataSnapshot snapshot) => {
            if (snapshot != null)
              {
                Navigator.pushNamedAndRemoveUntil(
                    context, MainPage.id, (route) => false),
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Image(
                height: 100,
                width: 100,
                image: AssetImage('images/logo.png'),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Sign in as Rider',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Brand-Bold',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 14),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TaxiOutlineButton(
                      onPressed: () async {
                        var conecetivityResult =
                            await Connectivity().checkConnectivity();
                        if (conecetivityResult != ConnectivityResult.mobile &&
                            conecetivityResult != ConnectivityResult.wifi) {
                          showSnakbar('No Internet Conection');
                        }
                        if (!emailController.text.contains('@')) {
                          showSnakbar('Please provide a valid email address');
                          return;
                        }
                        if (passwordController.text.length < 8) {
                          showSnakbar(
                              'Password must contain atleast 8 characters');
                          return;
                        }
                        login();
                      },
                      title: 'Login'.toUpperCase(),
                      color: BrandColors.colorGreen,
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegistrationPage.id, (route) => false);
                },
                child: Text('Don\'t have an account, sign up here'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
