import 'package:atticadesign/selldiditalsilver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'Api/api.dart';
import 'Helper/myCart.dart';
import 'Model/UserDetailsModel.dart';
import 'Utils/Common.dart';
import 'Utils/Razorpay.dart';
import 'goldcoinbar.dart';

import 'notifications.dart';

class SellDigitalGold extends StatefulWidget {
  const SellDigitalGold({Key? key}) : super(key: key);

  @override
  State<SellDigitalGold> createState() => _SellDigitalGoldState();
}

class _SellDigitalGoldState extends State<SellDigitalGold> {
  // double priceRange  = 10;
  final priceController = TextEditingController();
  double  resultGram = 0.0;
  double goldRate = 5323.96;
  TextStyle kTextStyle = TextStyle(
      fontSize: 14.0,
      // fontWeight: FontWeight.bold,
      color: Color(0xfffafcfb)
  );
  double min = 0, max = 100;
  RangeValues rangeValues = RangeValues(0, 100);

  @override
  void initState() {
    super.initState();
    getWallet();
  }

  UserDetailsModel userDetailsModel = UserDetailsModel();
  String goldWallet = "0";

  void getWallet() async {
    userDetailsModel =
    await userDetails(App.localStorage.getString("userId").toString());
    if (userDetailsModel != null &&
        userDetailsModel.data![0].goldWallet != null) {
      setState(() {
        print( userDetailsModel.data![0].goldWallet.toString());
        goldWallet = userDetailsModel.data![0].goldWallet.toString();
      });
    }
  }

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
          child: Image.asset('assets/images/newbackss.png'),
        ),
        title: Text(
          "Sell Digital Gold",
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
                      MaterialPageRoute(builder: (context) =>  MyCart()),
                    );
                  },
                  child: Icon(Icons.shopping_cart_rounded, color: Color(0xffF1D459))),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child:
                InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  NotiPage()),
                      );
                    },
                    child: Icon(Icons.notifications_active, color: Color(0xffF1D459))),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height*1.1,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xffF1D459),
                              Color(0xffB27E29),
                            ]),
                            // color: Color(0xff#F1D459),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/homepage/gold.png',
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Gold',
                                  style: TextStyle(
                                    color: Color(0xff0C3B2E),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 15),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xffE2E2E2),
                              Color(0xff717171),
                            ]),
                            // color: Color(0xff#F1D459),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) =>  SellDigitalSilver()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/homepage/silverbrick.png',
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Silver',
                                    style: TextStyle(
                                      color: Color(0xff0C3B2E),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  height: 230,
                  width: 340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Color(0xff24745E),
                      image: DecorationImage(
                        image: AssetImage("assets/onboarding/sellDidital.png"),
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 100.0, left: 20, top: 20),
                            child: Text(
                              'Start Buying \ndigital  gold \nNow',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '₹',
                              style: TextStyle(
                                color: Color(0xffF1D459),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Text(
                            '5362.39/gm',
                            style: TextStyle(
                              color: Color(0xffF1D459),
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Current buying price',
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Text(
                              'Price Valid For',
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              '02:44',
                              style: TextStyle(
                                color: Color(0xffF1D459),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 120.0, top: 12.0),
                  child: Text(
                    'How much you want to Pledge?',
                    style: TextStyle(
                      color: Color(0xffF3F3F3),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Gold Wallet Amount ${goldWallet.toString()}"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: priceController,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                            onFieldSubmitted: (value){
                              resultGram  =   goldRate * int.parse(value);
                              setState(() {
                              });
                            },
                            onChanged: (value){
                              resultGram  =   goldRate * int.parse(value);
                              setState(() {
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              //add prefix icon
                              prefixIcon: Icon(
                                Icons.person_outline_rounded,
                                color: Colors.grey,
                              ),
                              // errorText: "Please Enter Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                const BorderSide(color: Colors.blue, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.grey,
                              hintText: "Enter Gram",
                              //make hint text
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),

                              labelText: 'Enter Gram',
                              //lable style
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child:  Container(
                      //     height: 70,
                      //     width: 335,
                      //     decoration: BoxDecoration(
                      //       color: Color(0xff24745E),
                      //       borderRadius: BorderRadius.all(Radius.circular(10)),
                      //     ),
                      //    child:    Center(
                      //      child: Text(
                      //        'Gram ${resultGram.toStringAsFixed(3)} ',
                      //        style: TextStyle(
                      //          color: Color(0xffE2E2E2),
                      //          fontWeight: FontWeight.bold,
                      //          fontSize: 25,
                      //        ),
                      //      ),
                      //    ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xff24745E),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child:    Center(
                    child: Text(
                      'Amount ₹ ${resultGram.toStringAsFixed(3)} ',
                      style: TextStyle(
                        color: Color(0xffE2E2E2),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(0xff24745E)),
                    padding: EdgeInsets.only(
                        left:
                        ((MediaQuery.of(context).size.width - 10) / 10) / 2,
                        right: ((MediaQuery.of(context).size.width - 10) / 10) /
                            2),
                    width: MediaQuery.of(context).size.width,
                    // child:
                  ),
                ),

                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Row(
                    children: [
                      Text(
                        'Available Gold Balance :  ',
                        style: TextStyle(
                          color: Color(0xffE2E2E2),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '6553.00gm',
                        style: TextStyle(
                          color: Color(0xffF1D459),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Color(0xff24745E),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Total Gram:   ',
                          style: TextStyle(
                            color: Color(0xffE2E2E2),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        '6553.00gm',
                        style: TextStyle(
                          color: Color(0xffF1D459),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: (){
                    // RazorPayHelper razorHelper=new RazorPayHelper(price.text, context, (result){
                    //   if(result=="error"){
                    //     setState(() {
                    //       // saveStatus = true;
                    //     });
                    //   }else{
                    //     // addOrder();
                    //   }
                    // });
                    // razorHelper.init();
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: CircularProgressIndicator(color: Color(0xffF1D459),));

                    String iserId = App.localStorage.getString("userId").toString();
                    sellGoldOrSilver(iserId,priceController.text, resultGram,true ,context);
          },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(colors: [
                          Color(0xffF1D459),
                          Color(0xffB27E29),
                        ])),
                    child: Center(
                      child: Text(
                        'SELL NOW',
                        style: TextStyle(
                          color: Color(0xff0F261E),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class DynamicRangeSlider extends StatelessWidget {
  final Key? key;
  final RangeValues currentRangeValues;
  final double min, max;
  final onChanged, onChangeEnd;

  DynamicRangeSlider({
    this.key,
    required this.currentRangeValues,
    required this.min,
    required this.max,
    required this.onChanged,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: currentRangeValues,
      min:min,
      max: max,
      divisions: 100,
      labels: RangeLabels(
        currentRangeValues.start.round().toString(),
        currentRangeValues.end.round().toString(),
      ),
      onChanged: onChanged, // callback when the range values change
      onChangeEnd: onChangeEnd ??
          null,
      activeColor: Color(0xffB27E29),
      inactiveColor:Color(0xff2d4f44) ,
      // callback when the user is done selecting new values
    );
  }
}
