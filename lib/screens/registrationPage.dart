import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uberClone/screens/loginPage.dart';
import 'package:uberClone/screens/mainPage.dart';
import 'package:uberClone/widgets/ProgressIndicator.dart';
import 'package:uberClone/widgets/TaxiOutlineButton.dart';

import '../brand_colors.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnakbar(String title) {
    final snackBar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneNumberController = TextEditingController();

  var passwordController = TextEditingController();

  void registerUser() async {
    // show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(status: "Registering You..."),
    );
    final User user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((ex) {
      //check error and display msg
      Navigator.of(context).pop();

      PlatformException thisEx = ex;
      showSnakbar(thisEx.message);
    }))
        .user;

    Navigator.pop(context);

    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');

      //Prepare data to be saved on user table

      Map userMap = {
        'fullName': fullNameController.text,
        'emailAddress': emailController.text,
        'phoneNumber': phoneNumberController.text
      };
      newUserRef.set(userMap);
      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
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
                'Create a Rider\'s account',
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
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Full Name",
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
                      controller: phoneNumberController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
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
                      title: 'Register'.toUpperCase(),
                      color: BrandColors.colorGreen,
                      onPressed: () async {
                        // check network availabilty

                        var conecetivityResult =
                            await Connectivity().checkConnectivity();
                        if (conecetivityResult != ConnectivityResult.mobile &&
                            conecetivityResult != ConnectivityResult.wifi) {
                          showSnakbar('No Internet Conection');
                        }

                        if (fullNameController.text.length < 3) {
                          showSnakbar('Please provide a valid full name');
                          return;
                        }
                        if (!emailController.text.contains('@')) {
                          showSnakbar('Please provide a valid email address');
                          return;
                        }
                        if (phoneNumberController.text.length < 10) {
                          showSnakbar('Please provide a valid phone number');
                          return;
                        }

                        if (passwordController.text.length < 8) {
                          showSnakbar(
                              'Password must contain atleast 8 characters');
                          return;
                        }

                        registerUser();
                      },
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginPage.id, (route) => false);
                },
                child: Text('Already have a rider account? Log in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
