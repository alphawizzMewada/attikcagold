import 'package:flutter/material.dart';

import 'Api/api.dart';
import 'Helper/myCart.dart';
import 'Helper/myLocker.dart';
import 'Helper/transation_mode.dart';
import 'Model/transaction_model.dart';
import 'Utils/Common.dart';
import 'notifications.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff15654F),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff15654F),
          leading: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyLocker()),
              );
            },
            child: Image.asset(
              'assets/images/newbackss.png',
              height: 80,
            ),
          ),
          title: Text(
            "Transaction",
            style: TextStyle(
              color: Color(0xffF3F3F3),
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyCart()),
                      );
                    },
                    child: Icon(Icons.shopping_cart_rounded,
                        color: Color(0xffF1D459))),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotiPage()),
                        );
                      },
                      child: Icon(Icons.notifications_active,
                          color: Color(0xffF1D459))),
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff707070),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 12.0, left: 10, right: 15),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: '',
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Icon(
                                    Icons.search,
                                    color: Color(0xffF1D459),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      bottomSheet();
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/buydigitalgold/filter.png',
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Filters',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              typeSelect == "3" ? FutureBuilder(
                  future: getTransationCash(
                              App.localStorage.getString("userId").toString(),
                            ),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      TransationModeOnlyAmount? transationModel = snapshot.data;

                      return transationModel!.data!.length > 0
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: transationModel.data!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: Color(0xff24745E),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: ListTile(
                                          leading: Image.asset(
                                              "assets/images/lockercupan.png"),
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6),
                                            child: Text(
                                              "${transationModel.data![0].message}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          "${transationModel.data![0].dateCreated}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white54)),
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
                                  }),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                "No History Yet",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              )));
                    }
                    else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Container(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ));
                    }
                  }) : FutureBuilder(
                  future: typeSelect == "1"
                      ? getTransationType(
                      App.localStorage.getString("userId").toString(), "1")
                      : typeSelect == "2"
                      ? getTransationType(
                      App.localStorage.getString("userId").toString(),
                      "2")
                      : typeSelect == "3" ? getTransationCash(
                    App.localStorage.getString("userId").toString(),
                  ) : getTransation(
                    App.localStorage.getString("userId").toString(),
                  ),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      TransactionModel? transationModel = snapshot.data;

                      return transationModel!.data!.length > 0
                          ? Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: transationModel.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Color(0xff24745E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/images/lockercupan.png"),
                                    title: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Text(
                                        "${transationModel.data![0].purchaseType}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
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
                                                    color:
                                                    Colors.white54)),
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
                            }),
                      )
                          : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                                "No History Yet",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              )));
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
                  }) ,
              // Container(
              //   height: 90,
              //   width: 340,
              //   decoration: BoxDecoration(
              //       color: Color(0xff24745E),
              //       borderRadius:
              //           BorderRadius.all(Radius.circular(10))),
              //   child: ListTile(
              //     leading: Padding(
              //       padding: const EdgeInsets.only(top: 8.0),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => WalletTopups()),
              //             );
              //           },
              //           child: Image.asset(
              //               'assets/buydigitalgold/coup2.png')),
              //     ),
              //     title: Column(
              //       children: [
              //         Padding(
              //           padding:
              //               const EdgeInsets.only(right: 30.0, top: 20),
              //           child: Text(
              //             'Coupon Added',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 18,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 '05 July 2021',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 // Navigator.push(
              //                 //   context,
              //                 //   MaterialPageRoute(builder: (context) =>  SecondRoute()),
              //                 // );
              //               },
              //               child: Text(
              //                 '02:12',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     trailing: Padding(
              //       padding: const EdgeInsets.only(top: 20.0),
              //       child: Text(
              //         "₹ 99",
              //         style: TextStyle(
              //           color: Color(0xffF1D459),
              //           fontSize: 25,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   height: 90,
              //   width: 340,
              //   decoration: BoxDecoration(
              //       color: Color(0xff24745E),
              //       borderRadius:
              //           BorderRadius.all(Radius.circular(10))),
              //   child: ListTile(
              //     leading: Padding(
              //       padding: const EdgeInsets.only(top: 8.0),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       OrderDetailsPage()),
              //             );
              //           },
              //           child: Image.asset(
              //               'assets/buydigitalgold/coup2.png')),
              //     ),
              //     title: Column(
              //       children: [
              //         Padding(
              //           padding:
              //               const EdgeInsets.only(right: 30.0, top: 20),
              //           child: Text(
              //             'Added To wallet',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 18,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 '05 July 2021',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 // Navigator.push(
              //                 //   context,
              //                 //   MaterialPageRoute(builder: (context) => const SecondRoute()),
              //                 // );
              //               },
              //               child: Text(
              //                 '02:12',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     trailing: Padding(
              //       padding: const EdgeInsets.only(top: 20.0),
              //       child: Text(
              //         "₹ 12",
              //         style: TextStyle(
              //           color: Color(0xffF1D459),
              //           fontSize: 25,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   height: 90,
              //   width: 340,
              //   decoration: BoxDecoration(
              //       color: Color(0xff24745E),
              //       borderRadius:
              //           BorderRadius.all(Radius.circular(10))),
              //   child: ListTile(
              //     leading: Padding(
              //       padding: const EdgeInsets.only(top: 8.0),
              //       child: InkWell(
              //           onTap: () {
              //            /* Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => PayNow()),
              //             );*/
              //           },
              //           child: Image.asset(
              //               'assets/buydigitalgold/coup3.png')),
              //     ),
              //     title: Column(
              //       children: [
              //         Padding(
              //           padding:
              //               const EdgeInsets.only(right: 30.0, top: 20),
              //           child: Text(
              //             'Referral Money',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 18,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 '05 July 2021',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 // Navigator.push(
              //                 //   context,
              //                 //   MaterialPageRoute(builder: (context) => const SecondRoute()),
              //                 // );
              //               },
              //               child: Text(
              //                 '02:12',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     trailing: Padding(
              //       padding: const EdgeInsets.only(top: 20.0),
              //       child: Text(
              //         "₹ 30",
              //         style: TextStyle(
              //           color: Color(0xffF1D459),
              //           fontSize: 25,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   height: 90,
              //   width: 340,
              //   decoration: BoxDecoration(
              //       color: Color(0xff24745E),
              //       borderRadius:
              //           BorderRadius.all(Radius.circular(10))),
              //   child: ListTile(
              //     leading: Padding(
              //       padding: const EdgeInsets.only(top: 8.0),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => MyLocker()),
              //             );
              //           },
              //           child: Image.asset(
              //               'assets/buydigitalgold/coup2.png')),
              //     ),
              //     title: Column(
              //       children: [
              //         Padding(
              //           padding:
              //               const EdgeInsets.only(right: 30.0, top: 20),
              //           child: Text(
              //             'Referral Money',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 18,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 '05 July 2021',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 // Navigator.push(
              //                 //   context,
              //                 //   MaterialPageRoute(builder: (context) => const SecondRoute()),
              //                 // );
              //               },
              //               child: Text(
              //                 '02:12',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     trailing: Padding(
              //       padding: const EdgeInsets.only(top: 20.0),
              //       child: Text(
              //         "₹ 30",
              //         style: TextStyle(
              //           color: Color(0xffF1D459),
              //           fontSize: 25,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   height: 90,
              //   width: 340,
              //   decoration: BoxDecoration(
              //       color: Color(0xff24745E),
              //       borderRadius:
              //           BorderRadius.all(Radius.circular(10))),
              //   child: ListTile(
              //     leading: Padding(
              //       padding: const EdgeInsets.only(top: 8.0),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => CouponCode()),
              //             );
              //           },
              //           child: Image.asset(
              //               'assets/buydigitalgold/coup2.png')),
              //     ),
              //     title: Column(
              //       children: [
              //         Padding(
              //           padding:
              //               const EdgeInsets.only(right: 10.0, top: 20),
              //           child: Text(
              //             'Added To wallet',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 18,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 '05 July 2021',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 // Navigator.push(
              //                 //   context,
              //                 //   MaterialPageRoute(builder: (context) => const SecondRoute()),
              //                 // );
              //               },
              //               child: Text(
              //                 '02:12',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     trailing: Padding(
              //       padding: const EdgeInsets.only(top: 20.0),
              //       child: Text(
              //         "₹ 80",
              //         style: TextStyle(
              //           color: Color(0xffF1D459),
              //           fontSize: 25,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   height: 90,
              //   width: 340,
              //   decoration: BoxDecoration(
              //       color: Color(0xff24745E),
              //       borderRadius:
              //           BorderRadius.all(Radius.circular(10))),
              //   child: ListTile(
              //     leading: Padding(
              //       padding: const EdgeInsets.only(top: 8.0),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => ChangeNumber()),
              //             );
              //           },
              //           child: Image.asset(
              //               'assets/buydigitalgold/coup2.png')),
              //     ),
              //     title: Column(
              //       children: [
              //         Padding(
              //           padding:
              //               const EdgeInsets.only(right: 30.0, top: 20),
              //           child: Text(
              //             'Referral Money',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 18,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 '05 July 2021',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 // Navigator.push(
              //                 //   context,
              //                 //   MaterialPageRoute(builder: (context) => const SecondRoute()),
              //                 // );
              //               },
              //               child: Text(
              //                 '02:12',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     trailing: Padding(
              //       padding: const EdgeInsets.only(top: 20.0),
              //       child: Text(
              //         "₹ 30",
              //         style: TextStyle(
              //           color: Color(0xffF1D459),
              //           fontSize: 25,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   height: 90,
              //   width: 340,
              //   decoration: BoxDecoration(
              //       color: Color(0xff24745E),
              //       borderRadius:
              //           BorderRadius.all(Radius.circular(10))),
              //   child: ListTile(
              //     leading: Padding(
              //       padding: const EdgeInsets.only(top: 8.0),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => EditProfile()),
              //             );
              //           },
              //           child: Image.asset(
              //               'assets/buydigitalgold/coup2.png')),
              //     ),
              //     title: Column(
              //       children: [
              //         Padding(
              //           padding:
              //               const EdgeInsets.only(right: 30.0, top: 20),
              //           child: Text(
              //             'Referral Money',
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 18,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         Row(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(left: 10.0),
              //               child: Text(
              //                 '05 July 2021',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 // Navigator.push(
              //                 //   context,
              //                 //   MaterialPageRoute(builder: (context) => const SecondRoute()),
              //                 // );
              //               },
              //               child: Text(
              //                 '02:12',
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //     trailing: Padding(
              //       padding: const EdgeInsets.only(top: 20.0),
              //       child: Text(
              //         "₹ 30",
              //         style: TextStyle(
              //           color: Color(0xffF1D459),
              //           fontSize: 25,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }

  var typeSelect = "0";
  bool isCash = false;
  void bottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Color(0xff0C3B2E),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Text(
                  "Select Type",
                  style: TextStyle(color: Colors.orange),
                ),
                trailing: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    typeSelect = "1";
                    isCash = false;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text(
                    "Only Gold Transaction",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    typeSelect = "2";
                    isCash = false;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Only Silver Transaction",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Card(
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15.0),
              //     ),
              //     color: Color(0xff376356),
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         height: 36,
              //         child: TextField(
              //           maxLines: 1,
              //           style: TextStyle(fontSize: 17),
              //           textAlignVertical: TextAlignVertical.center,
              //           decoration: InputDecoration(
              //               border: InputBorder.none,
              //               filled: true,
              //               hintStyle: TextStyle(color: Color(0xffFFFFFFF)),
              //               hintText: 'DD/MM/YY',
              //               suffixIcon: Icon(
              //                 Icons.calendar_today_outlined,
              //                 color: Colors.orange,
              //                 size: 20,
              //               )),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 100, right: 100, top: 40, bottom: 20),
              //   child: ElevatedButton(
              //     child: Text('APPLY',style: TextStyle(color: Color(0xff0F261E),fontSize: 20),),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const Transaction()),
              //       );
              //     },
              //     style: ElevatedButton.styleFrom(
              //         primary: Color(0xFFB27E29),
              //         fixedSize: Size(180,60),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(40),
              //         ),
              //         textStyle:
              //         TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    typeSelect = "3";
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Only Cash Transaction",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

            ],
          ),
        );
      },
    );
  }
}

