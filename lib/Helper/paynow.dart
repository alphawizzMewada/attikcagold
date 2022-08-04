import 'dart:async';
import 'dart:convert';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/order%20_Confirmed.dart';
import 'package:atticadesign/Model/cart_model.dart';
import 'package:atticadesign/Model/voucher_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Razorpay.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PayNow extends StatefulWidget {
  double? discount, total, subTotal,proDiscount;
  VoucherModel? model;
  String gramValue;
  String? time="", des,deliveryCharge;
  String deliveryStatus;
  PayNow(this.discount, this.total, this.model, this.time, this.des,
      this.subTotal,this.deliveryStatus,this.deliveryCharge, this.gramValue);

  @override
  State<PayNow> createState() => _PayNowState();
}

class _PayNowState extends State<PayNow> {
  String taxAmount ="0",taxPer = "0";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15654F),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF15654F),
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/images/newbackss.png",
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          "Pay Now",
          style: TextStyle(color: Colors.white54),
        ),
       /* actions: [
          Image.asset(
            "assets/images/shop.png",
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset(
              "assets/images/well.png",
              height: 20,
              width: 20,
            ),
          ),
        ],*/
      ),
      body: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: getWidth1(49)),
        child: Column(
          children: [
            boxHeight(20),
            Card(
              color: Color(0xFF376356),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                width: getWidth1(600),
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/newRoza.png",
                  height: 80,
                  width: 50,
                ),
              ),
            ),
            boxHeight(100),
            InkWell(
              onTap: () {
                RazorPayHelper razorHelper=new RazorPayHelper(widget.total.toString(), context, (result){
                  if(result=="error"){
                    setState(() {
                      saveStatus = true;
                    });
                  }else{
                    addOrder();
                  }
                },App.localStorage.getString("userId").toString(),widget.gramValue.toString(),false,true);
                razorHelper.init();
              },
              child: Container(
                height: getHeight1(70),
                width: getWidth1(400),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23.0),
                    gradient: LinearGradient(
                      colors: [Color(0xffF1D459), Color(0xffB27E29)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                child: Center(
                  child: saveStatus?Text(
                    "CONTINUE PAYMENT",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff004B3F),fontSize: 20,fontWeight: FontWeight.bold),
                  ):
                  CircularProgressIndicator(
                    color: MyColorName.colorTextFour,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  bool walletStatus = false;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  bool loadingCart = false;
  int? currentIndex;
  List<CartModel> cartList = [];
  List<String> productId = [];
  List<String> quantity = [];
  bool saveStatus = true;
  getCart() async {
    try {
      setState(() {
        loadingCart = false;
        cartList.clear();
      });
      Map params = {
        "get_user_cart": "1",
        "user_id": curUserId.toString(),
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "get_user_cart"), params);
      setState(() {
        loadingCart = true;
      });
      if (!response['error']) {
        for (var v in response['data']) {
          setState(() {
            productId.add(v['product_variant_id']);
            quantity.add(v['qty']);
            taxAmount = response['tax_amount'];
            taxPer = response['tax_percentage'];
          });
        }
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }
  addOrder({String type =""}) async {
    App.init();
    try {
      setState(() {
        saveStatus = false;
      });
      print("ok");
      double amount = 0;
      print(amount);
      Map params = {
        "place_order": "1",
        "user_id": curUserId.toString(),
        "mobile": App.localStorage.getString("phone").toString(),
        "order_note": widget.des.toString()!=""?widget.des.toString():"No Note",
        "product_variant_id": productId.toString().replaceAll("[", "").replaceAll("]", ""),
        "quantity":quantity.toString().replaceAll("[", "").replaceAll("]", ""),
        "total": widget.subTotal.toString(),
        "delivery_charge": widget.deliveryCharge,
        "latitude":latitude.toString(),
        "longitude": longitude.toString(),
        "tax_amount": taxAmount.toString(),
        "tax_percentage": taxPer.toString(),
        "wallet_balance": "0",
        "is_wallet_used":"0",
        "wallet_balance_used":"0",
        "address_id": addressId.toString(),
        "final_total":  widget.total.toString(),
        "pro_discount": widget.proDiscount.toString(),
        "payment_method": "Razorpay",
        "delivery_time": widget.time.toString()==""?"Express Delivery":jsonEncode(widget.time).toString(),
        "accesskey": "90336".toString(),
        "status":"received",
      };
      if(widget.model!=null){
        params['promo_code']=widget.model!.promo_code.toString();
        params['promo_discount']= widget.discount!=null?widget.discount.toString():"";
      }
      print(baseUrl + "place_order");
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "place_order"), params);

      setState(() {
        saveStatus = true;
      });
      if (!response['error']) {
        navigateScreen(context, OrderConfirmed());
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }
}
