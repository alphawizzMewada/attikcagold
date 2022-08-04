import 'dart:async';
import 'dart:math';

import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/screen/voucher_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

// import 'package:toggle_switch/toggle_switch.dart';

import 'Api/api.dart';
import 'Helper/Session.dart';
import 'Helper/myCart.dart';
import 'Model/UserDetailsModel.dart';
import 'Model/voucher_model.dart';
import 'Utils/ApiBaseHelper.dart';
import 'Utils/Common.dart';
import 'Utils/Razorpay.dart';
import 'Utils/colors.dart';
import 'Utils/widget.dart';
import 'buydiditalsilver.dart';
import 'notifications.dart';

class BuyDigitalGold extends StatefulWidget {
  const BuyDigitalGold({Key? key}) : super(key: key);

  @override
  State<BuyDigitalGold> createState() => _BuyDigitalGoldState();
}

class _BuyDigitalGoldState extends State<BuyDigitalGold> {
  List categories = ['₹10', '₹20', '₹50', '₹100'];
  List selectedCategories = [];
  var selected = '';
  TextEditingController choiceAmountController = TextEditingController();
  double resultGram = 0.000000;

  double goldRate = 5246.96;
  Razorpay? _razorpay;
  String razorPayKey = "rzp_test_UUBtmcArqOLqIY";
  String razorPaySecret = "NTW3MUbXOtcwUrz5a4YCshqk";
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void initState() {
    super.initState();
    getWallet();
  }

  UserDetailsModel userDetailsModel = UserDetailsModel();
  String goldWallet = "0000000000";

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
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/images/newbackss.png',
            height: 80,
          ),
        ),
        title: Text(
          "Buy Digital Gold",
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
                      MaterialPageRoute(builder: (context) => NotiPage()),
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
                        MaterialPageRoute(builder: (context) => MyCart()),
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
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>  PledgeGold()),
                          // );
                        },
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
                ),
                SizedBox(
                  width: 10,
                ),
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
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuyDigitalSilver()),
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
              height: 15,
            ),
            Container(
              height: 250,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.only(top: 12, left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Color(0xff24745E),
                  image: DecorationImage(
                    image: AssetImage("assets/homepage/coinback.png"),
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
                          'Start Buying \ndigital  silver \nNow',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Total Gold Waleet ₹ ${goldWallet.substring(0,8)}',
                    style: TextStyle(
                      color: Color(0xffF1D459),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 10.0),
                  //       child: Text(
                  //         'Current buying price',
                  //         style: TextStyle(
                  //           color: Color(0xffffffff),
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 10,
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 40,
                  //     ),
                  //     // Padding(
                  //     //   padding: const EdgeInsets.only(left: 50),
                  //     //   child: Text(
                  //     //     'Price Valid For',
                  //     //     style: TextStyle(
                  //     //       color: Color(0xffffffff),
                  //     //       fontWeight: FontWeight.bold,
                  //     //       fontSize: 10,
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //     // Padding(
                  //     //   padding: const EdgeInsets.only(left: 5.0),
                  //     //   child: Text(
                  //     //     '02:44',
                  //     //     style: TextStyle(
                  //     //       color: Color(0xffF1D459),
                  //     //       fontWeight: FontWeight.bold,
                  //     //       fontSize: 10,
                  //     //     ),
                  //     //   ),
                  //     // )
                  //   ],
                  // )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                'How much you want to buy?',
                style: TextStyle(
                  color: Color(0xffF3F3F3).withOpacity(1),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),

            SizedBox(
              height: 10,
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
                        controller: choiceAmountController,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                        onFieldSubmitted: (value) {
                          // choiceAmountController.text = value;
                          resultGram = int.parse(value) / goldRate;
                          setState(() {});
                        },
                        onChanged: (value) {
                          resultGram = int.parse(value) / goldRate;
                          setState(() {});
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
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "₹ Enter Amount",
                          //make hint text
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),

                          labelText: '₹ Enter Amount',
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
              height: MediaQuery.of(context).size.height * 0.08,
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xff24745E),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  'Gram ${resultGram.toStringAsFixed(3)} ',
                  style: TextStyle(
                    color: Color(0xffE2E2E2),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            /* Container(
              height: 10,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return  Container(
                      child: ChoiceChip(
                        shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(left: Radius.circular(25), right: Radius.circular(25))
                        ),
                        side: BorderSide(width: 1, color: Color(0xff0C3B2E)),
                        backgroundColor: Color(0xff15654F),
                        label: Text('1000',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:Colors.white, fontSize: 20)),
                        labelPadding:
                        EdgeInsets.symmetric(horizontal: 12),
                        selected: choiceAmountController == '1000',
                        onSelected: (bool selected) {
                          setState(() {
                            choiceAmountController.text = (selected ? '1000' : '') ;
                            print("10::---$choiceAmountController");
                            resultGram  =   int.parse(choiceAmountController.text)/ goldRate;
                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                    );
                  }),
            ),*/
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(25),
                                right: Radius.circular(25))),
                        side: BorderSide(width: 1, color: Color(0xff0C3B2E)),
                        backgroundColor: Color(0xff15654F),
                        label: Text('1000',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        labelPadding: EdgeInsets.symmetric(horizontal: 12),
                        selected: choiceAmountController == '1000',
                        onSelected: (bool selected) {
                          setState(() {
                            choiceAmountController.text =
                                (selected ? '1000' : '');
                            print("10::---$choiceAmountController");
                            resultGram =
                                int.parse(choiceAmountController.text) /
                                    goldRate;
                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(25),
                                right: Radius.circular(25))),
                        side: BorderSide(width: 1, color: Color(0xff0C3B2E)),
                        backgroundColor: Color(0xff15654F),
                        label: Text('2000',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffF3F3F3).withOpacity(0.5),
                                fontSize: 20)),
                        labelPadding: EdgeInsets.symmetric(horizontal: 12),
                        // selected: choice== 'right',
                        selected: choiceAmountController == '2000',
                        onSelected: (bool selected) {
                          setState(() {
                            print("20::");
                            choiceAmountController.text =
                                (selected ? '2000' : '');
                            resultGram =
                                int.parse(choiceAmountController.text) /
                                    goldRate;
                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(25),
                                right: Radius.circular(25))),
                        side: BorderSide(width: 1, color: Color(0xff0C3B2E)),
                        backgroundColor: Color(0xff15654F),
                        label: Text('5000',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffF3F3F3).withOpacity(0.5),
                                fontSize: 20)),
                        labelPadding: EdgeInsets.symmetric(horizontal: 12),
                        selected: choiceAmountController == '5000',
                        onSelected: (bool selected) {
                          setState(() {
                            print("50::");
                            choiceAmountController.text =
                                (selected ? '5000' : '');
                            resultGram =
                                int.parse(choiceAmountController.text) /
                                    goldRate;
                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                        // height: MediaQuery.of(context).size.height*0.50,
                      ),
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(25),
                                right: Radius.circular(25))),
                        side: BorderSide(width: 1, color: Color(0xff0C3B2E)),
                        backgroundColor: Color(0xff15654F),
                        label: Text('10000',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffF3F3F3).withOpacity(0.5),
                                fontSize: 20)),
                        labelPadding: EdgeInsets.symmetric(horizontal: 12),
                        selected: choiceAmountController == '10000',
                        onSelected: (bool selected) {
                          setState(() {
                            print("100::");
                            choiceAmountController.text =
                                (selected ? '10000' : '');
                            resultGram =
                                int.parse(choiceAmountController.text) /
                                    goldRate;
                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 120.0),
              child: Text(
                'You can Buy up to 1000 per day',
                style: TextStyle(
                  color: Color(0xffE2E2E2),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   height: 80,
            //   width: 335,
            //   decoration: BoxDecoration(
            //     color: Color(0xff15654F),
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 10),
            //     child: ListTile(
            //       leading: Image.asset(
            //         "assets/buydigitalgold/coupon.png",
            //         width: 50,
            //       ),
            //       title: Row(
            //         children: [
            //           Divider(
            //             color: Colors.white,
            //             thickness: 10,
            //           ),
            //           Text(
            //             'Apply coupon code',
            //             style: TextStyle(
            //               color: Color(0xffE2E2E2),
            //               // fontWeight: FontWeight.bold,
            //               fontSize: 15,
            //             ),
            //           )
            //         ],
            //       ),
            //       trailing: Container(
            //         height: 30,
            //         width: 80,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(20)),
            //             gradient: LinearGradient(colors: [
            //               Color(0xffFF7162),
            //               Color(0xffF32F4C),
            //             ])),
            //         child: Center(
            //           child: InkWell(
            //             onTap: () {},
            //             child: Text(
            //               'View All',
            //               style: TextStyle(
            //                 color: Color(0xffE2E2E2),
            //                 fontSize: 12,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            voucherView(),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {

                RazorPayHelper razorHelper = new RazorPayHelper(
                    choiceAmountController.text, context, (result) {
                  if (result == "error") {
                    setState(() {
                    });
                  }
                }, curUserId!, resultGram.toString(), true,false);
                razorHelper.init();
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    gradient: LinearGradient(colors: [
                      Color(0xffF1D459),
                      Color(0xffB27E29),
                    ])),
                child: Center(
                  child: Text(
                    'BUY NOW',
                    style: TextStyle(
                      color: Color(0xff0F261E),
                      fontSize: 18,
                    ),
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
    );
  }

  voucherView() {
    return Container(
      height: getHeight1(144),
      width: getWidth1(622),
      decoration: boxDecoration(
        radius: 15,
        bgColor: MyColorName.colorTextFour.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getWidth1(16),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/buydigitalgold/coupon.png",
            width: getWidth1(79),
            height: getHeight1(54),
            fit: BoxFit.fill,
          ),
          boxWidth(20),
          Container(
              child: text("You have a Voucher",
                  fontSize: 10.sp, fontFamily: fontRegular)),
          boxWidth(20),
          InkWell(
            onTap: () async {
              var result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VoucherListView()));
              print(result);
              if (result != null) {
                setState(() {
                  model = null;
                  voucher = null;
                });
                addVoucher(choiceAmountController.text, result.promo_code, result);
              }
            },
            child: Container(
              width: getWidth1(160),
              height: getHeight1(55),
              decoration:
              boxDecoration(radius: 48, bgColor: MyColorName.primaryDark),
              child: Center(
                child: text("See All",
                    fontFamily: fontMedium,
                    fontSize: 10.sp,
                    textColor: MyColorName.colorTextPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ApiBaseHelper apiBase = new ApiBaseHelper();
  addVoucher(total, promoCode, model1) async {
    try {
      Map params = {
        "validate_promo_code": "1",
        "user_id": curUserId.toString(),
        "final_total": choiceAmountController.text.toString(),
        "promo_code": promoCode.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "validate_promo_code"), params);

      if (!response['error']) {
        setState(() {
          model = model1;
          voucher =
              double.parse(response['data'][0]['final_discount'].toString());
          choiceAmountController.text = response['data'][0]['final_total'].toString() ;
        });
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
      });
    }
  }
  double? voucher;
  VoucherModel? model;

}
