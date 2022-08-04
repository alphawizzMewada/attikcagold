import 'package:atticadesign/Helper/couponCode.dart';
import 'package:atticadesign/Helper/myCart.dart';
import 'package:atticadesign/Helper/paynow.dart';
import 'package:flutter/material.dart';

import 'notifications.dart';

class OrderConfirm3 extends StatefulWidget {
  const OrderConfirm3({Key? key}) : super(key: key);

  @override
  State<OrderConfirm3> createState() => _OrderConfirm3State();
}

class _OrderConfirm3State extends State<OrderConfirm3> {
  String? _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff15654F),
          leading:
          InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyCart()),
                );
              },child: Image.asset("assets/images/newbackss.png")),
          title: Text(
            "Order Confirm",
            style: TextStyle(
              color: Color(0xffF3F3F3),
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
                Icon(Icons.shopping_cart_rounded, color: Color(0xffF1D459)),
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
        bottomNavigationBar:  Container(
          height: 80,width: 400,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xffB98A0A),
                    Color(0xffF1D459),
                  ]

              )
          ),
          child: Row(
            children: [
              Container(
                height: 50,width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffB98A0A),
                        Color(0xffF1D459),
                      ],
                    )
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MyCart()),
                    );
                  },
                  child: Center(
                    child: Text("CANCEL",style: TextStyle(
                      color: Color(0xffF32F4C),fontSize: 20,fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
              ),
              SizedBox(width: 20,),
              InkWell(
                onTap: (){
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  PayNow()),
                  );*/
                },
                child: Container(
                  height: 50,width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffF1D459),
                          Color(0xffB27E29),
                        ],
                      )
                  ),
                  child: Center(
                    child: Text("PAY NOW",
                        style: TextStyle(
                          color: Color(0xff004B3F),fontSize: 20,fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 1.7,
              ),
              child: Container(
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/homepage/vertical.png',
                      ),
                      fit: BoxFit.cover,
                    )),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                      height: 60,width: 335,
                      decoration: BoxDecoration(
                        color: Color(0xff24745E),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Text("Choose Your Delivery Location Type",style: TextStyle(color: Colors.white),),
                          trailing: Icon(Icons.keyboard_arrow_down,color: Colors.yellow,),
                        ),
                      ),
                      // child: Card(
                      //   color: Color(0xff15654F),
                      //   child: Column(
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: DropdownButton(
                      //             hint: _dropDownValue == null
                      //                 ? Padding(
                      //               padding: const EdgeInsets.only(left: 10.0),
                      //               child: Text('Choose Your Delivery Location Type',style: TextStyle(
                      //                 color: Colors.white,fontSize: 15,
                      //               ),),
                      //             )
                      //                 : Text(
                      //               _dropDownValue!,
                      //               style: TextStyle(color: Colors.white),
                      //             ),
                      //             isExpanded: true,
                      //             iconSize: 40.0,
                      //
                      //             iconEnabledColor: Colors.yellow,
                      //             dropdownColor: Colors.white54,
                      //             style: TextStyle(color: Colors.black),
                      //             items: ['Home', 'Office', 'AnyOther'].map(
                      //                   (val) {
                      //                 return DropdownMenuItem<String>(
                      //                   value: val,
                      //                   child: Text(val),
                      //                 );
                      //               },
                      //             ).toList(),
                      //             onChanged: (val) {
                      //               setState(
                      //                     () {
                      //                   _dropDownValue = val as String?;
                      //                 },
                      //               );
                      //             }),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 160,width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Card(
                        color: Color(0xff15654F),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.add_location_alt_outlined,color: Colors.yellow,),
                              title: Text("Delivery Address",style: TextStyle(
                                color: Colors.white,fontSize: 14,
                              ),),
                              trailing:  Icon(Icons.more_vert,color: Colors.yellow,),
                            ),
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 25.0,top: 8),
                            //       child: Image.asset('assets/images/Path .png',height: 30,),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 20.0,top: 20),
                            //       child: Text("Delivery Address",style: TextStyle(
                            //         color: Colors.white,fontSize: 14,
                            //       ),),
                            //     ),
                            //     Icon(Icons.more_vert)
                            //   ],
                            // ),
                            // SizedBox(height: 20,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Text("573,Ravij Colony Prakesh Nagar Colony,\n  Nagda Madhya Pradesh,456335, India",style: TextStyle(
                                    color: Colors.white,fontSize: 13,
                                  ),),
                                ),
                              ],
                            ),
                            Divider(color: Colors.black54,),

                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Icon(Icons.speaker_notes,color: Colors.white,),
                                ),
                                SizedBox(width: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 60.0),
                                  child: Text('Add Notes For Your Delivery',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 160,width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        color: Color(0xff24745E),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,top: 10),
                                  child: Image.asset('assets/images/radio.png',height: 25,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,top: 10.0),
                                  child: Text('Gold',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                                SizedBox(width: 5,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,top: 10.0),
                                  child: Image.asset('assets/images/radio.png',height: 25,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,top: 10.0),
                                  child: Text('Silver',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text('Redeem Locker Gold',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  height: 40,width: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xff15654F),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Text("256 g",style: TextStyle(
                                      color: Color(0xffF1D459),fontSize: 20,
                                    ),),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text('Redemption Amount',style: TextStyle(
                                    color: Colors.yellow,fontSize: 15,
                                  ),),
                                ),
                                SizedBox(width: 20,),
                                Container(
                                  height: 40,width: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xff15654F),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Center(
                                    child: Text("₹ 2250",style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 20,
                                    ),),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),

                    Container(
                      height: 190,width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Card(
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(10.0),
                        //     topRight: Radius.circular(10.0)
                        //   )
                        // ),
                        color: Color(0xff004B3F),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10),
                              child: Image.asset('assets/buydigitalgold/meter.png',
                                alignment: AlignmentDirectional.center,
                              ),
                            ),
                            ListTile(
                              leading: Text("Min",style: TextStyle(
                                color: Colors.white,fontSize: 15,
                              ),),
                              trailing: Text("Max",style: TextStyle(
                                color: Colors.white,fontSize: 15,
                              ),),
                            ),
                            Container(
                              height: 50,width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffF1D459),
                                      Color(0xffB27E29),
                                    ],
                                  )
                              ),
                              child: Center(
                                child: Text("Confirm Redemption",
                                    style: TextStyle(
                                      color: Color(0xff004B3F),fontSize: 15,fontWeight: FontWeight.bold,
                                    )
                                ),
                              ),
                            ),

                            SizedBox(height: 10,),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      height: 80,width: 340,
                      decoration: BoxDecoration(
                        color: Color(0xff24745E),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Image.asset("assets/buydigitalgold/coupon.png",height: 50,),
                          ),
                          SizedBox(width: 20,),
                          Text("Apply coupon code",style: TextStyle(
                            color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            height: 30,width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                gradient: LinearGradient(colors: [
                                  Color(0xffFF7162),
                                  Color(0xffF32F4C),
                                ])
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  CouponCode()),
                                  );
                                },
                                child: Text("View all",style: TextStyle(
                                  color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),
                    Text("Your Cart Summary",style: TextStyle(
                      color: Color(0xffF4B71E),fontSize: 20,fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 300,width: 340,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Card(
                        color: Color(0xff15654F),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,top: 20.0),
                                  child: Text("Sub Total ( 3 Items)",style: TextStyle(
                                    color: Color(0xffF1D459),fontSize: 15,
                                  ),),
                                ),
                                SizedBox(width: 30,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0,top: 20.0),
                                  child: Text("₹ 120000.75",style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                              ],
                            ),
                            Divider(color: Colors.white,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text('Redemption Amount',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                                SizedBox(width: 40,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0,),
                                  child: Text('₹ 200',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                )
                              ],
                            ),SizedBox(height: 12,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text('Voucher Discount',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                                SizedBox(width: 55,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0,),
                                  child: Text('₹ 00',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                )
                              ],
                            ),SizedBox(height: 12,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text('Delivery Charges',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                                SizedBox(width: 60,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0,),
                                  child: Text('₹ 200',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                )
                              ],
                            ),SizedBox(height: 12,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text('Redemption Amount',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                                SizedBox(width: 40,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0,),
                                  child: Text('₹ 200',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                )
                              ],
                            ),SizedBox(height: 12,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text('Tax Rate',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                                SizedBox(width: 120,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0,),
                                  child: Text('₹ 14%',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                )
                              ],
                            ),SizedBox(height: 12,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text('IGST',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 195.0,),
                                  child: Text('₹ 5600',style: TextStyle(
                                    color: Colors.white,fontSize: 15,
                                  ),),
                                )
                              ],
                            ),SizedBox(height: 12,),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text('Total',style: TextStyle(
                                    color: Color(0xffF1D459),fontSize: 20,
                                  ),),
                                ),
                                SizedBox(width: 100,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0,),
                                  child: Text('₹ 125800.75',style: TextStyle(
                                    color: Color(0xffF1D459),fontSize: 20,
                                  ),),
                                )
                              ],
                            )
                          ],
                        ),


                      ),
                    ),



                  ],
                ),
              ),
            )));
  }

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
        break;
      case 1:
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => ContactUs()));
        break;
    }
  }
}
