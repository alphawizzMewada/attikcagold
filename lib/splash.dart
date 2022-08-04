import 'dart:async';

import 'package:atticadesign/Helper/introoooo.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/PushNotificationService.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'Helper/intro.dart';

class MySplshScreen extends StatefulWidget {
  @override
  _MySplshScreen createState() => _MySplshScreen();
}

class _MySplshScreen extends State<MySplshScreen> {
  @override
  void initState() {
    super.initState();
    final pushNotificationService = PushNotificationService(
        context: context);
    pushNotificationService.initialise();
    Timer(
        Duration(seconds: 3),
        () => changePage());
  }
  changePage()async{
    await App.init();
    print(App.localStorage.getString("userId"));
    if(App.localStorage.getString("userId")!=null){
      curUserId = App.localStorage.getString("userId").toString();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> BottomBar()), (route) => false);
    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
          builder: (context) => IntroImage(),
    ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.grey[900],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7), BlendMode.dstATop),
          image: const AssetImage('assets/splash/bacgnd.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/splash/attica.png',
            width: 280,
          ),
        ],
      ),
    );
  }
}
