import 'dart:convert';

import 'package:atticadesign/Helper/sellSilverModel.dart';
import 'package:atticadesign/Model/pruchaseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Helper/transation_mode.dart';
import '../Model/AddToCardModel.dart';
import '../Model/EditProfileModel.dart';
import '../Model/GetCartModel.dart';
import '../Model/GetCouponModel.dart';
import '../Model/GetGoldCoinModel.dart';
import '../Model/GetWishListModel.dart';
import '../Model/NumberModel.dart';
import '../Model/PrivacyPolicy.dart';
import '../Model/UserDetailsModel.dart';
import '../Model/homeSlider_model.dart';
import '../Model/login_model.dart';
import '../Model/productDetails_model.dart';
import '../Model/registrtion_model.dart';
import '../Model/termsandConditions_model.dart';
import '../Model/transaction_model.dart';
import '../Utils/Common.dart';
import '../Utils/constant.dart';

//TextEditingController tokenCtrl = TextEditingController();
String baseUrl1 = "https://alphawizztest.tk/Atticadigitamarketing/app/v1/api/";
String razorPayKey = "rzp_test_UUBtmcArqOLqIY";

Future<RegistrtionModel?> registration(name, mobile, gender, age) async {
  var headers = {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NTMxMjA4MDgsImlzcyI6ImVzaG9wIiwiZXhwIjoxNjUzMTIyNjA4fQ.pZicHCyfhwwor-RsPF9H0u0CXZzevBy0u_JA3Vk1GsI',
  };
  var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'register'));
  request.fields.addAll({
    'name': '$name',
    'mobile': '$mobile',
    'gender': 'male',
    'age': '12',
    'email': 'alpdha@gmail.com',
    'password': '12345678'
  });

  print(request);
  print(request.fields);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return RegistrtionModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<LoginModel?> login(mobile) async {
  var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'login'));
  request.fields.addAll({'mobile': '$mobile'});
  print(request);
  print(request.fields.toString() + "ssss");
  // request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return LoginModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<PrivacyPolicy?> privacyPolicy() async {
  var headers = {
    'Cookie':
        'ci_session=2i228lq631ebvjeli9s2e28mvhjhsb5r; ekart_security_cookie=7ed2dd51fda10d7c683041e2e6fbf938'
  };
  var request = http.Request('GET', Uri.parse(baseUrl1 + 'get_privacy_policy'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return PrivacyPolicy.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<TermsandConditionsModel?> termsandConditions() async {
  var headers = {
    'Cookie':
        'ci_session=2i228lq631ebvjeli9s2e28mvhjhsb5r; ekart_security_cookie=7ed2dd51fda10d7c683041e2e6fbf938'
  };
  var request = http.Request('GET', Uri.parse(baseUrl1 + 'terms_conditions'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TermsandConditionsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<HomeSliderModel?> homeSlider() async {
  var request = http.Request('GET', Uri.parse(baseUrl1 + 'get_slider_images'));

  // request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  print(response.statusCode);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return HomeSliderModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<ProductDetailsModel?> productDetails() async {
  var headers = {
    'Cookie':
        'ci_session=me3pm54rt85a7q3gl2an6odso1pr3ci5; ekart_security_cookie=8eaf16bd90e896dc92628c1bcd875530'
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_productdetails'));
  request.fields
      .addAll({'id': App.localStorage.getString("userId").toString()});

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return ProductDetailsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetGoldCoinModel?> goldCoin(category_id) async {
  var headers = {
    'Cookie':
        'ci_session=b3ohruen23f9ttjeekldaee4lm2u5qc4; ekart_security_cookie=8eaf16bd90e896dc92628c1bcd875530'
  };
  var request = http.MultipartRequest(
      'POST', Uri.parse(baseUrl1 + 'get_productdlisting'));
  request.fields.addAll({'category_id': '$category_id'});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetGoldCoinModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<AddToCardModel?> addtocard(userid, qty, productid) async {
  var headers = {'Cookie': 'ci_session=eug6v2np9dp2fa13onevi9eqmlfdlg3a'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'add_to_cart'));
  request.fields.addAll(
      {'user_id': '$userid', 'qty': '$qty', 'product_id': '$productid'});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return AddToCardModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetCartModel?> getCartdata(userid) async {
  var headers = {'Cookie': 'ci_session=2kcgb2bdv86mqm266sc5o3ab60ql616l'};
  var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_cart'));
  request.fields.addAll({'user_id': '$userid'});
  print(request);
  print(request.fields);
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetCartModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetWishListModel?> getwishlist(userid) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_favorites'));
  request.fields
      .addAll({'user_id': App.localStorage.getString("userId").toString()});

  print(request);
  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetWishListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetCouponModel?> getCouponcode() async {
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_promo_codes'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetCouponModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<TransationModeOnlyAmount?> getTransationCash(String? userId) async {
  TransationModeOnlyAmount transationMode = TransationModeOnlyAmount();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl + 'transactions'));
  request.fields.addAll({
    'user_id': App.localStorage.getString("userId").toString(),
    'transaction_type':"wallet",
    'type':"debit",
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TransationModeOnlyAmount.fromJson(json.decode(str));
  } else {
    return transationMode;
  }
}

Future<TransactionModel?> getTransation(id) async {
  TransactionModel transationMode = TransactionModel();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl + 'all_transcation'));
  request.fields.addAll({
    'user_id': id,
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TransactionModel.fromJson(json.decode(str));
  } else {
    return transationMode;
  }
}

Future<TransactionModel?> getTransationType(id, type) async {
  TransactionModel transationMode = TransactionModel();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl + 'all_transcation'));
  request.fields.addAll({'user_id': id, "type": type});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TransactionModel.fromJson(json.decode(str));
  } else {
    return transationMode;
  }
}

Future<EditProfileModel?> editprofle(String name, String mobile) async {
  var headers = {
    'Cookie':
        'ci_session=8phq7qv7e51gq7jh41q3ea8n4ei0c75m; ekart_security_cookie=75e4d3b861f7e0403f42abd768a206e0'
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'update_profile'));
  request.fields.addAll({
    'id': App.localStorage.getString("userId").toString(),
    'username': 'Shubham Shinde',
    'mobile': '7485968574',
    'image': 'Screenshot_from_2022-03-29_19-10-51.png'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return EditProfileModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<NumberModel?> changeNumber(String mobile) async {
  var headers = {'Cookie': 'ci_session=ptfjdlp3dfa4u1a8q25ojul1nqh48e0o'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'change_number'));
  request.fields.addAll({
    'id': App.localStorage.getString("userId").toString(),
    'Mobile': '1234567892'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return NumberModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<PruchaseModel?> purchaseGold(
    userId, buyAmount, gramValue, isGold, context) async {
  String goldurl = baseUrl1 + "pruchase_gold";
  String silveryrl = baseUrl1 + "purchase_sliver";
  PruchaseModel pruchaseModel = PruchaseModel();
  var request =
      http.MultipartRequest('POST', Uri.parse(isGold ? goldurl : silveryrl));

  request.fields.addAll({
    'user_id': userId,
    'razorpay_payment_id': razorPayKey,
    'buy_amount': buyAmount,
    'gold': '$gramValue'
  });

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    Navigator.pop(context);
    return PruchaseModel.fromJson(json.decode(str));
  } else {
    Navigator.pop(context);
    return pruchaseModel;
  }
}

Future<UserDetailsModel> userDetails(userId) async {
  UserDetailsModel userDetailsModel = UserDetailsModel();
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'user_datails'));
  request.fields
      .addAll({'user_id': App.localStorage.getString("userId").toString()});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return UserDetailsModel.fromJson(json.decode(str));
  } else {
    return userDetailsModel;
  }
}

Future<SellSilverGoldModel> sellGoldOrSilver(
    userId, sell, total, isGold, context) async {
  var headers = {'Cookie': 'ci_session=369m0tojim7hjgo5dt6dlc7skt0cl5kf'};
  SellSilverGoldModel sellSilverGoldModel = SellSilverGoldModel();
  String goldSellUrl = "sell_gold";
  String silverSellUrl = "sell_silver";
  var request = http.MultipartRequest('POST',
      Uri.parse(isGold ? baseUrl + goldSellUrl : baseUrl + silverSellUrl));
  request.fields
      .addAll({'user_id': '$userId', 'sell': '$sell', 'total': '$total'});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    Navigator.pop(context);
    return SellSilverGoldModel.fromJson(json.decode(str));
  } else {
    Navigator.pop(context);
    return sellSilverGoldModel;
  }
}
