
import 'package:atticadesign/Helper/productDetailsDialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'Helper/myCart.dart';
import 'helpandsupport.dart';
import 'notifications.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff15654F),
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
              child: Image.asset('assets/images/newbackss.png',)),
          title: Text(
            "Order Details",
            style: TextStyle(
              color: Color(0xffF3F3F3),
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCart()),
                    );
                  },
                    child: Icon(Icons.shopping_cart_rounded, color: Color(0xffF1D459))),
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
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 1.8,
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
                      Container(
                        height: 250,width: 350,
                        child: Card(
                          color: Color(0xff15654F),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: Image.asset('assets/buydigitalgold/goldcoinbar.png',height: 150,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(right: 200.0,top: 8),
                        child: Text('Order Details',style: TextStyle(
                          color: Color(0xffF1D459).withOpacity(1),fontSize: 20,fontWeight: FontWeight.bold,
                        ),),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 300,width: 350,
                        child: Card(
                          color: Color(0xff15654F),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Text('Order Name',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),SizedBox(width: 20,),
                                    Text('24K Gold Coin (99.99%) Pure',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0,left: 20),
                                    child: Text('Weight',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),
                                  ),SizedBox(width: 20,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0,left: 40,),
                                    child: Text('0.5 gram',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0,left: 20),
                                    child: Text('Order Date',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),
                                  ),SizedBox(width: 20,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0,left: 40,),
                                    child: Text('26 Feb 2022',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0,left: 20),
                                    child: Text('Order Time',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),
                                  ),SizedBox(width: 20,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0,left: 40,),
                                    child: Text('01:24 PM',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40.0,left: 20),
                                    child: Text('Order Id #',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),
                                  ),SizedBox(width: 20,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40.0,left: 40,),
                                    child: Text('403-997714541-66584',style: TextStyle(
                                      color: Color(0xffffffff),fontSize: 15,
                                    ),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(right: 200.0,top: 10,),
                        child: Text('Shipping Details',style: TextStyle(
                          color: Color(0xffF1D459).withOpacity(1),fontSize: 20,fontWeight: FontWeight.bold,
                        ),),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding:  EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 200,width: 350,
                          child: Card(
                            color: Color(0xff15654F),
                            child:  Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0,left: 20),
                                      child: Text('Order Status :',style: TextStyle(
                                        color: Color(0xffffffff),fontSize: 20,
                                      ),),
                                    ),SizedBox(width: 20,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0,left: 10,),
                                      child: Text('Delivered',style: TextStyle(
                                        color: Color(0xff98C924),fontSize: 20,
                                      ),),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 15.0,left: 10,),
                                        child: Image.asset('assets/images/greenright.png',height: 20,)
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40.0,right: 170,),
                                  child: Text('Billing Address',style: TextStyle(
                                    color: Color(0xffffffff),fontSize: 20,
                                  ),),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(top: 10.0,left: 15.0,right: 15.0),
                                      child: Text(''' 573,Ravij Colony Prakesh Nagar Colony,\n Nagda Madhya Pradesh , 456335, India''',
                                        textAlign: TextAlign.justify,style: TextStyle(
                                        color: Color(0xffffffff),fontSize: 14,
                                      ),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                          Padding(
                            padding:  EdgeInsets.only(right: 150.0,),
                            child: Text('Payment Information',style: TextStyle(
                              color: Color(0xffF1D459),fontSize: 20,fontWeight: FontWeight.bold,
                            ),),
                          ),
                         SizedBox(height: 10,),
                         Container(
                           height: 60,width: 350,
                           child: Card(
                             color: Color(0xff15654F),
                             child: Row(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 20.0),
                                   child: Text('Payment Method',style: TextStyle(
                                     color: Color(0xffffffff),fontSize: 20,fontWeight: FontWeight.bold,
                                   ),),
                                 ),
                                 SizedBox(width: 50,),
                                 Text('Online',style: TextStyle(
                                   color: Color(0xff98C924),fontSize: 20,fontWeight: FontWeight.bold,
                                 ),)
                               ],
                             ),
                           ),
                         ),
                          SizedBox(height: 10,),
                          Padding(
                            padding:  EdgeInsets.only(right: 180.0,),
                            child: Text('Order Summary',style: TextStyle(
                              color: Color(0xffF1D459),fontSize: 20,fontWeight: FontWeight.bold,
                            ),),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 230,width: 350,
                            child: Card(
                              color: Color(0xff15654F),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0,),
                                          child: Text('Sub Total',style: TextStyle(
                                            color: Color(0xffffffff),fontSize: 15,
                                          ),),
                                        ),
                                        SizedBox(width: 100,),
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Text('₹ 225.00',style: TextStyle(
                                            color:  Color(0xffffffff),fontSize: 15,fontWeight: FontWeight.bold,
                                          ),),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0,),
                                          child: Text('Delivery Charge',style: TextStyle(
                                            color: Color(0xffffffff),fontSize: 15,
                                          ),),
                                        ),
                                        SizedBox(width: 60,),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Text('₹ 50.00',style: TextStyle(
                                            color:  Color(0xffffffff),fontSize: 15,fontWeight: FontWeight.bold,
                                          ),),
                                        )
                                      ],
                                    ),SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0,),
                                          child: Text('Tax',style: TextStyle(
                                            color: Color(0xffffffff),fontSize: 15,
                                          ),),
                                        ),
                                        SizedBox(width: 140,),
                                        Text('₹ 28.00',style: TextStyle(
                                          color:  Color(0xffffffff),fontSize: 15,fontWeight: FontWeight.bold,
                                        ),)
                                      ],
                                    ),SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0,),
                                          child: Text('Discount',style: TextStyle(
                                            color: Color(0xffffffff),fontSize: 15,
                                          ),),
                                        ),
                                        SizedBox(width:105,),
                                        Text('₹ - 75.00',style: TextStyle(
                                          color:  Color(0xffffffff),fontSize: 15,fontWeight: FontWeight.bold,
                                        ),)
                                      ],
                                    ),SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0),
                                          child: Text('Order Total',style: TextStyle(
                                            color: Color(0xffF1D459),fontSize: 20,fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                        SizedBox(width: 60,),
                                        Text('₹ 228.00',style: TextStyle(
                                          color:  Color(0xffF1D459),fontSize: 20,fontWeight: FontWeight.bold,
                                        ),)
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ProductDetailsDialog()),
                              );
                            },
                            child: Container(
                              height: 50,width: 350,
                              decoration: BoxDecoration(
                                  color: Color(0xff15654F),
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(30),
                                color: Color(0xffF1D459),
                                strokeWidth: 2,
                                child:  Center(
                                  child: Text('GIVE FEEDBACK',style: TextStyle(
                                      color: Color(0xffF1D459),fontSize: 20,fontWeight: FontWeight.bold
                                  ),),
                                ),

                              ),


                            ),
                          ),

                    ]
                    )
                )
            )
        )
    );
  }
}
