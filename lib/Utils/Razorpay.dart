import 'dart:convert';
import 'dart:math';

import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Api/api.dart';
import '../Helper/Session.dart';
import '../Helper/transation_mode.dart';
import '../Model/addAmountModel.dart';


String razorPayKey="rzp_test_UUBtmcArqOLqIY";
String razorPaySecret="NTW3MUbXOtcwUrz5a4YCshqk";
class RazorPayHelper{
  String amount;
  String? orderId;
  BuildContext context;
  ValueChanged onResult;
  String userid;
  String gramValue;
  bool isGold;
  Razorpay? _razorpay;
  bool isOrderProduct;
  RazorPayHelper(this.amount, this.context, this.onResult,this.userid, this.gramValue, this.isGold, this.isOrderProduct,);
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  init(){
    CircularProgressIndicator(color: Color(0xffF1D459),);
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    if(isOrderProduct){
      getOrder();
    }else{
      openCheckout(amount);
    }
  }



  void getOrder() async {
    String username = razorPayKey;
    String password = razorPaySecret;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    double newmoney=double.parse(amount.toString())*100;
    int nw=newmoney.toInt();
    print(nw);
    Map data = {
      "amount":nw.toString(),
      "currency": "INR",
      "receipt": "receipt_" + getRandomString(5)
    }; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!

    var headers = {"content-type": "application/json"};

    var res = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: <String, String>{'authorization': basicAuth}, body: data);
    print(res.body);
    if (res.statusCode == 200) {
      Map data2 = json.decode(res.body);
      orderId = data2['id'];
      Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: CircularProgressIndicator(color: Color(0xffF1D459),));
      sellGoldOrSilver(userid, amount, gramValue, isGold, context);
    }
    else {
      print(res.body);
      print(res.statusCode);
    }
  }

  void openCheckout(String amt) async {
    await App.init();
    var options = {
      'key': razorPayKey,
      'amount': amt,
      'name': 'Attica Gold',
      "order_id":orderId,
      'description': "Order #"+getRandomString(5),
      'external': {
        'wallets': ['paytm']
      },
      'prefill': {
        'name': name,
        'contact': App.localStorage.getString("phone"),
        'email': email,},
      "notify": {
        "sms": true,
        "email": true
      },
      "reminder_enable": true,
    };

    try {
      _razorpay!.open(options);
    } catch (e) {

      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if(!isOrderProduct&& gramValue != null && gramValue.toString().length > 1){
      purchaseGold(userid, amount, gramValue, isGold, context);
    }else{
      addAmountBalance(amount: amount, orderId: response.paymentId, status: "success", tranxId: response.paymentId,
      userId: userid);
    }
  }

  Future<AddAmountModel?> addAmountBalance({String? userId, String? amount, String? orderId,String? status,
    String? tranxId, }) async {
    AddAmountModel transationMode = AddAmountModel();
    var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl + 'add_transaction'));

    request.fields.addAll({
      "transaction_type": "wallet",
      "user_id": "$userId",
      "order_id": "$orderId",
      "type": "debit",
      "payment_method": "razorpay",
      "txn_id": "$tranxId",
      "amount": "$amount",
      "status": "$status",
      "message": "Done",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Navigator.pop(context);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str);
      return AddAmountModel.fromJson(json.decode(str));
    } else {
      return transationMode;
    }
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    setSnackbar("Payment Cancelled", context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // onResult(response.walletName);
    }
}