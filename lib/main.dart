import 'dart:io';

import 'package:atticadesign/Helper/couponCode.dart';
import 'package:atticadesign/Helper/editProfile.dart';
import 'package:atticadesign/Helper/intro.dart';
import 'package:atticadesign/Helper/kYC.dart';
import 'package:atticadesign/Helper/productDetails.dart';
import 'package:atticadesign/Helper/wallettopup.dart';
import 'package:atticadesign/Model/productDetails_model.dart';
import 'package:atticadesign/Utils/PushNotificationService.dart';
import 'package:atticadesign/authentication/login.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:atticadesign/buydigitalgold.dart';
import 'package:atticadesign/goldcoinbar.dart';
import 'package:atticadesign/orderconfirm.dart';
import 'package:atticadesign/orderconfirm2.dart';
import 'package:atticadesign/pledgegold.dart';
import 'package:atticadesign/pledgesilver.dart';
import 'package:atticadesign/selldiditalsilver.dart';
import 'package:atticadesign/selldigitalgold.dart';
import 'package:atticadesign/silvercoinbar.dart';
import 'package:atticadesign/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'Helper/changeNumber.dart';
import 'Helper/myLocker.dart';
import 'HomePage.dart';
import 'authentication/SignUp.dart';
import 'authentication/demo.dart';
import 'authentication/otp.dart';
import 'development.dart';

void main()async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  runApp(const MyApp());
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      Sizer(
        builder: (context,orientation,deviceType) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
       theme: ThemeData.dark(),
       darkTheme: ThemeData.dark(),
        /*theme: ThemeData(
          primarySwatch: Colors.blue,
        ),*/
        home: MySplshScreen(),
    );
        }
      );
  }
}