import 'package:atticadesign/Helper/wishlist.dart';
import 'package:atticadesign/HomePage.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/authentication/login.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:atticadesign/notifications.dart';
import 'package:atticadesign/privacypolicy.dart';
import 'package:atticadesign/screen/address_list_view.dart';
import 'package:atticadesign/screen/order_list.dart';
import 'package:atticadesign/splash.dart';
import 'package:atticadesign/termsandcondition.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/walletList.dart';
import '../helpandsupport.dart';
import '../orderHistory.dart';
import 'editProfile.dart';

import 'kYC.dart';



class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  void initState() {
    super.initState();
    getSaved();
  }

  getSaved() async {
    await App.init();
    if (App.localStorage.getString("address") != null) {
      setState(() {
        deliveryLocation = App.localStorage.getString("address").toString();
      });
    }
    if (App.localStorage.getString("image") != null) {
      setState(() {
        image = App.localStorage.getString("image").toString();
      });
    }
    if (App.localStorage.getString("name") != null) {
      setState(() {
        name = App.localStorage.getString("name").toString();
      });
    }
    if (App.localStorage.getString("email") != null) {
      setState(() {
        email = App.localStorage.getString("email").toString();
      });
    }
    if (App.localStorage.getString("phone") != null) {
      setState(() {
        mobile = App.localStorage.getString("phone").toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F261E),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF15654F),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/images/newbackss.png",
            height: 80,
            width: 80,
          ),
        ),
        title: Text("My Account"),
        actions: [

          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotiPage()),
              );
            },

            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                "assets/images/well.png",
                height: 15,
                width: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: commonHWImage(
                  image,
                  100.0,
                  100.0,
                  "assets/images/manuser.png",
                  context,
                  "assets/images/manuser.png"
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Text(name,
                style: TextStyle(color: Colors.white,fontSize: 20))),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff24745E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset("assets/images/edit.png",height: 20,),
                    onTap: ()async{
                      var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                      if(result!=null){
                        getSaved();
                      }
                    },
                    title: Text("Edit Profile",style: TextStyle(color: Colors.white,fontSize: 18),),

                    trailing: Image.asset("assets/images/rightarrow.png",height: 20,),

                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Card(
            //     color: Color(0xff24745E),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15.0),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(20.0),
            //       child: Row(
            //         children: [
            //           Image.asset("assets/images/yourkyc.png",height: 20,),
            //           SizedBox(width: 20,),
            //           InkWell(
            //             onTap: (){
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(builder: (context) =>  KYC()),
            //               );
            //             },
            //
            //               child: Padding(
            //                 padding: const EdgeInsets.only(left: 15),
            //                 child: Text("Your KYC",style: TextStyle(color: Colors.white,fontSize: 17)),
            //               )),
            //           SizedBox(width: 20,),
            //           Image.asset("assets/images/redregtangle.png",height: 20,),
            //           SizedBox(width: 10,),
            //           Text("Not Verified",style: TextStyle(color: Color(0xffFF0000),fontSize: 15)),
            //           SizedBox(width: 30,),
            //           Image.asset("assets/images/rightarrow.png",height: 20,),
            //         ],
            //       ),
            //     ),
            //   ),
            //
            // ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff24745E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset("assets/images/wishlist.png",height: 20,),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Wishlist()),
                      );
                    },
                    title: Text("Wish list",style: TextStyle(color: Colors.white,fontSize: 18),),
                    trailing: Image.asset("assets/images/rightarrow.png",height: 20,),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff24745E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.location_on,size: 24.sp,color:MyColorName.colorIcon,),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AddressList(false,false)),
                      );
                    },
                    title: Text("My Address",style: TextStyle(color: Colors.white,fontSize: 18),),
                    trailing: Image.asset("assets/images/rightarrow.png",height: 20,),

                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Card(
            //     color: Color(0xff24745E),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15.0),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: ListTile(
            //         leading:  Icon(Icons.account_balance_wallet,color:MyColorName.colorIcon),
            //         onTap: (){
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) =>  WalletList()),
            //           );
            //         },
            //         title: Text("My Wallet",style: TextStyle(color: Colors.white,fontSize: 18),),
            //         trailing:
            //         Image.asset("assets/images/rightarrow.png",height: 20,),
            //
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff24745E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  OrderList()),
                      );
                    },
                    leading: Image.asset("assets/images/myoder.png",height: 20,),
                    title: Text("Order History",style: TextStyle(color: Colors.white,fontSize: 18),),
                    trailing: Image.asset("assets/images/rightarrow.png",height: 20,),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff24745E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    leading: Image.asset("assets/images/helpsupport.png",height: 20,),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  HelpAndSupport()),
                      );
                    },
                    title: Text("Help and support",style: TextStyle(color: Colors.white,fontSize: 18),),
                    trailing: Image.asset("assets/images/rightarrow.png",height: 20,),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff24745E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  PrivacyPolicyPage()),
                      );
                    },
                    leading: Image.asset("assets/images/privacy.png",height: 20,),
                    title: Text("Privacy Policy",style: TextStyle(color: Colors.white,fontSize: 18),),
                    trailing: Image.asset("assets/images/rightarrow.png",height: 20,),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff24745E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  TermsAndConditions()),
                      );
                    },
                    leading: Image.asset("assets/images/term.png",height: 20,),
                    title: Text("Terms and Conditions",style: TextStyle(color: Colors.white,fontSize: 18),),
                    trailing: Image.asset("assets/images/rightarrow.png",height: 20,),

                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color(0xff24745E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: (){
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Logout"),
                              content: Text("Do You Want to Logout ?"),

                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text('No'),
                                  /*textColor: MyColorName.primaryDark,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.transparent)),*/
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                ElevatedButton(
                                    child: Text('Yes'),
                                    /* shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.transparent)),
                          textColor: MyColorName.primaryDark,*/
                                    onPressed: () async {
                                      await App.init();
                                      App.localStorage.clear();
                                      //Common().toast("Logout");
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MySplshScreen()), (route) => false);
                                    }),
                              ],
                            );
                          });
                    },
                    leading: Image.asset("assets/images/logout.png",height: 20,),
                    title: Text("Log Out",style: TextStyle(color: Colors.white,fontSize: 18),),
                    trailing: Image.asset("assets/images/rightarrow.png",height: 20,),

                  ),
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
