import 'package:atticadesign/Helper/transation_mode.dart';
import 'package:atticadesign/Helper/wallettopup.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:atticadesign/transaction.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../Model/UserDetailsModel.dart';
import '../Model/transaction_model.dart';
import '../Utils/Common.dart';

class MyLocker extends StatefulWidget {
  const MyLocker({Key? key}) : super(key: key);

  @override
  State<MyLocker> createState() => _MyLockerState();
}

class _MyLockerState extends State<MyLocker> {


  @override
  void initState() {
    super.initState();
    getWallet();
  }

  UserDetailsModel userDetailsModel = UserDetailsModel();
  String silverWallet = "0.00000000" , goldenWallet = "0.000000", totalBalance = "0.0000000";

  void getWallet() async {
    userDetailsModel =
    await userDetails(App.localStorage.getString("userId").toString());
    if (userDetailsModel != null &&
        userDetailsModel.data![0].silverWallet != null) {
      setState(() {
        print( userDetailsModel.data![0].silverWallet.toString());
        silverWallet = userDetailsModel.data![0].silverWallet.toString();
      });
    }
    if (userDetailsModel != null &&
        userDetailsModel.data![0].goldWallet != null) {
      setState(() {
        print( userDetailsModel.data![0].goldWallet.toString());
        goldenWallet = userDetailsModel.data![0].goldWallet.toString();
      });
    }
    if (userDetailsModel != null &&
        userDetailsModel.data![0].balance != null) {
      setState(() {
        print( userDetailsModel.data![0].balance.toString());
        totalBalance = userDetailsModel.data![0].balance.toString();
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomBar()),
            );
          },
          child: Image.asset(
            "assets/images/newbackss.png",
            height: 80,
            width: 80,
          ),
        ),
        title: Text("My Locker"),
        actions: [
          Image.asset(
            "assets/images/shop.png",
            height: 15,
            width: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              "assets/images/well.png",
              height: 15,
              width: 20,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Available Cash Balance",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "₹ $totalBalance",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: RichText(
                  //         text: TextSpan(
                  //           style: TextStyle(color: Colors.black, fontSize: 18),
                  //           children: <TextSpan>[
                  //             TextSpan(
                  //                 text: 'Add More',
                  //                 style: TextStyle(
                  //                     decoration: TextDecoration.underline,
                  //                     color: Color(0xffFBD01D)))
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
              height: 120,
              width: 280,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/lockerback.png"),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletTopups()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffF1D459), Color(0xffB27E29)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                height: 40,
                width: 180,
                child: Center(
                  child: Text(
                    "ADD AMOUNT",
                    style: TextStyle(color: Color(0xff004B3F), fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),


          ExpansionTile(
              childrenPadding: const EdgeInsets.all(8.0),
              leading: Container(
                decoration: BoxDecoration(
                    // color: Colors
                    ),
                child: Text(
                  'Withdraw Amount',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                '',
                style: Theme.of(context).textTheme.headline6,
              ),
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffffff).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30.0)),
                        height: 50,
                        width: 300,
                        child: TextField(
                          maxLines: 1,
                          style: TextStyle(fontSize: 17),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            hintStyle: TextStyle(color: Color(0xffF1D459)),
                            hintText: ("Enter Amount"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffF1D459), Color(0xffB27E29)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    height: 35,
                    width: 160,
                    child: Center(
                      child: Text(
                        "WITHDRAW",
                        style:
                            TextStyle(color: Color(0xff004B3F), fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ]),
          SizedBox(
            height: 10,
          ),
          Card(
            color: Color(0xff15654F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                "assets/images/fill.png",
                                height: 20,
                              ),
                            ),
                            Text(
                              "Available Gold Balance",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                "₹ ${goldenWallet.substring(0,7)}",
                                style: TextStyle(color: Color(0xffF1D459), fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, right: 10),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Buy More',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff98C924)))
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/lockerback.png"),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(height: 10),
                Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset(
                                "assets/images/unfill.png",
                                height: 20,
                              ),
                            ),
                            Text(
                              " Available Silver balance",
                              style: TextStyle(color: Color(0xffF1D459), fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                "₹ ${silverWallet.substring(0,7)}",
                                style: TextStyle(color: Color(0xffF1D459), fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, right: 10),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Buy More',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff98C924)))
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/lockerback.png"),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffF1D459), Color(0xffB27E29)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    height: 35,
                    width: 160,
                    child: Center(
                      child: Text(
                        "DELIVER TO ME",
                        style:
                            TextStyle(color: Color(0xff004B3F), fontSize: 15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Text(
              "Recent Transaction History",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            trailing: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Transaction()),
                  );
                },
                child: Text(
                  "View All",
                  style: TextStyle(color: Color(0xffF1D459), fontSize: 17),
                )),
          ),
          FutureBuilder(
              future: getTransation(App.localStorage.getString("userId").toString()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  TransactionModel? transationModel = snapshot.data;
                  return transationModel!.data!.length > 0 ?
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: transationModel.data!.length > 3 ? 4 : transationModel.data!.length,
                      itemBuilder: (context, index){
                        return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Color(0xff24745E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                  "assets/images/lockercupan.png"),
                              title: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: Text(
                                  "${transationModel.data![0].purchaseType}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),

                              subtitle: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                          "${transationModel.data![0].createdAt}",
                                          style: TextStyle(
                                              color: Colors.white54)),
                                    ],
                                  ),
                                ),
                              ),
                              trailing: Text(
                                "₹ ${transationModel.data![0].amount}",
                                style: TextStyle(
                                    color: Color(0xffF1D459),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        );
                      }
                  ) : Center(child: Text("No Transaction Available"));
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ));
                }
              })

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     color: Color(0xff24745E),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: ListTile(
          //       leading: Image.asset("assets/images/addition.png"),
          //       title: Text(
          //         "Added To wallet",
          //         style: TextStyle(color: Colors.white, fontSize: 18),
          //       ),
          //       subtitle: RichText(
          //         text: TextSpan(
          //           style: TextStyle(color: Colors.black, fontSize: 17),
          //           children: <TextSpan>[
          //             TextSpan(
          //                 text: '05 July 2021',
          //                 style: TextStyle(color: Colors.white54)),
          //             TextSpan(
          //                 text: '   02:12',
          //                 style: TextStyle(color: Colors.white54)),
          //           ],
          //         ),
          //       ),
          //       trailing: Text(
          //         "₹ 12",
          //         style: TextStyle(color: Color(0xffF1D459), fontSize: 20),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     color: Color(0xff24745E),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: ListTile(
          //       leading: Image.asset("assets/images/lockeruser.png"),
          //       title: Text(
          //         "Referral Money",
          //         style: TextStyle(color: Colors.white, fontSize: 18),
          //       ),
          //       subtitle: RichText(
          //         text: TextSpan(
          //           style: TextStyle(color: Colors.black, fontSize: 17),
          //           children: <TextSpan>[
          //             TextSpan(
          //                 text: '05 July 2021',
          //                 style: TextStyle(color: Colors.white54)),
          //             TextSpan(
          //                 text: '   02:12',
          //                 style: TextStyle(color: Colors.white54)),
          //           ],
          //         ),
          //       ),
          //       trailing: Text(
          //         "₹ 30",
          //         style: TextStyle(color: Color(0xffF1D459), fontSize: 20),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     color: Color(0xff24745E),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: ListTile(
          //       leading: Image.asset("assets/images/lockeruser.png"),
          //       title: Text(
          //         "Referral Money",
          //         style: TextStyle(color: Colors.white, fontSize: 18),
          //       ),
          //       subtitle: RichText(
          //         text: TextSpan(
          //           style: TextStyle(color: Colors.black, fontSize: 17),
          //           children: <TextSpan>[
          //             TextSpan(
          //                 text: '05 July 2021',
          //                 style: TextStyle(color: Colors.white54)),
          //             TextSpan(
          //                 text: '   02:12',
          //                 style: TextStyle(color: Colors.white54)),
          //           ],
          //         ),
          //       ),
          //       trailing: Text(
          //         "₹ 30",
          //         style: TextStyle(color: Color(0xffF1D459), fontSize: 20),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
