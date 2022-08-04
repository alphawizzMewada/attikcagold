import 'dart:async';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sizer/sizer.dart';

class OtpPage extends StatefulWidget {
  final otp;
  String data;
   OtpPage({Key? key, this.otp,required this.data}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  String dont = "Don't share it with any other";
  String dontresend = "Didn't Got Code? Resend";

  BoxDecoration get pinPutDecoration {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      border: Border.all(color: Colors.white.withOpacity(0.2)),
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0F261E),
        appBar: PreferredSize(
          preferredSize: Size(100.w,12.h),

          child: AppBar(
           centerTitle: true,
            flexibleSpace: Image.asset(
              'assets/otppage/cover.png',
              fit: BoxFit.fill,
            ),
            title: Text(
              'OTP',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.21),
              ),
            ) ,
          ),
        ),
        body:   SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boxHeight(40),
              Text(
                'Enter Your 6 Digit code',
                style: TextStyle(
                    color: Color(0xffF3F3F3),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${dont}',
                style: TextStyle(
                    color: Color(0xffAFAFAF).withOpacity(1),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'OTP ${widget.otp}',
                style: TextStyle(
                    color: Color(0xffAFAFAF).withOpacity(1),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  // width: 180,
                  margin: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: PinPut(
                    fieldsCount: 6,
                    eachFieldHeight: 20,
                    eachFieldWidth: 12.36,
                    textStyle: TextStyle(
                      color: Colors.amber,
                      fontSize: 15,
                    ),
                    focusNode: pinPutFocusNode,
                    controller: pinPutController,
                    submittedFieldDecoration: pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '${dontresend}',
                style: TextStyle(
                  color: Color(0xffF95873).withOpacity(0.8),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  if(pinPutController.text==widget.otp){
                    setState(() {
                      loading =true;
                    });
                    verifyUser();
                  }else{
                    setSnackbar("Wrong OTP", context);
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffF1D459),
                            Color(0xffB27E29),
                          ]),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Center(
                      child: !loading?Text(
                        'VERIFY',
                        style: TextStyle(
                          color: Color(0xff0F261E).withOpacity(1),
                          fontSize: 20,
                        ),
                      ):Center(child: CircularProgressIndicator(color: Colors.white,)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = false;
  verifyUser() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "mobile": widget.data.toString(),
          "otp": widget.otp,
        };
        Map response =
        await apiBase.postAPICall(Uri.parse(baseUrl + "verify_otp"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          loading = false;
        });
        setSnackbar(msg, context);
        if(!response['error']){
          Map data = response['data'][0];
          App.localStorage.setString("userId", data['id']);
          App.localStorage.setString("name", data['username']);
          App.localStorage.setString("phone", data['mobile']);
          App.localStorage.setString("email", data['email'].toString());
          App.localStorage.setString("token", data['fcm_id'].toString());
          App.localStorage.setString("image", data['image'].toString());
          App.localStorage.setString("address", data['address'].toString());
          App.localStorage.setString("refer", data['referral_code'].toString());
          curUserId = data['id'];
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomBar()),
          );
        }else{

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        loading = false;
      });
    }
  }
}
