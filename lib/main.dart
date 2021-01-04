import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uberClone/screens/loginPage.dart';
import 'package:uberClone/screens/mainPage.dart';
import 'package:uberClone/screens/registrationPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
            appId: '1:974485830529:ios:1555add3248b4cd49f4680',
            apiKey: 'AIzaSyA9W6D6Tbyks1TmL_WrwPpgXQI9EFfT0Ik',
            projectId: 'shahisawari-9dc64',
            messagingSenderId: '974485830529',
            databaseURL:
                'https://shahisawari-9dc64-default-rtdb.firebaseio.com',
          )
        : FirebaseOptions(
            appId: '1:974485830529:android:ae64ab4f7bd68fc59f4680',
            apiKey: 'AIzaSyCjhvNvkS1HY9A3388I9YjeUkkhyQtRbpQ',
            messagingSenderId: '974485830529',
            projectId: 'shahisawari-9dc64',
            databaseURL:
                'https://shahisawari-9dc64-default-rtdb.firebaseio.com',
          ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber Clone',
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RegistrationPage.id,
      routes: {
        RegistrationPage.id: (context) => RegistrationPage(),
        MainPage.id: (context) => MainPage(),
        LoginPage.id: (context) => LoginPage(),
      },
    );
  }
}
