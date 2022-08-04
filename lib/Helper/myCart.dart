import 'dart:async';
import 'dart:async';

import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Model/GetCartModel.dart';
import 'package:atticadesign/Model/cart_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/String.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:atticadesign/notifications.dart';
import 'package:atticadesign/orderconfirm.dart';
import 'package:atticadesign/orderconfirm2.dart';
import 'package:atticadesign/screen/cart_product_view.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  bool loadingCart = false;
  int? currentIndex;
  List<CartModel> cartList = [];
  int totalCount = 0, currentCount = 0;
  String productImage = "", productName = "";
  double subTotal=0,deliveryCharge=0,tax=0,totalAmount=0,proDiscount = 0;
  getCart() async {
    try {
      setState(() {
        loadingCart = false;
        totalCount = 0;
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
            cartList.add(new CartModel.fromJson(v));
            totalCount += parseInt(v['qty']);
          });
        }
        setState(() {
          subTotal = double.parse(response['sub_total'].toString());
          if(response['delivery_charge']!=null){
            deliveryCharge = double.parse(response['delivery_charge'].toString());
          }
          if(response['tax_amount']!=null){
            tax = double.parse(response['tax_amount'].toString());
          }
          totalAmount = subTotal+deliveryCharge+tax;
        });
      } else {
        setState(() {
          subTotal=0;deliveryCharge=0;tax=0;totalAmount=0;
        });
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
    if (currentCount == 0) {
      setState(() {
        currentCount = totalCount;
      });
    }
  }
  getTotal() async {
    try {
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
        setState(() {
          subTotal = double.parse(response['sub_total'].toString());
          if(response['delivery_charge']!=null){
            deliveryCharge = double.parse(response['delivery_charge'].toString());
          }
          if(response['total_tax']!=null){
            tax = double.parse(response['tax_amount'].toString());
          }

          totalAmount = subTotal+deliveryCharge+tax;
        });
      } else {
        setState(() {
          subTotal=0;deliveryCharge=0;tax=0;totalAmount=0;
        });
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
    if (currentCount == 0) {
      setState(() {
        currentCount = totalCount;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();

  }

  void addCart(i) {
    Map data1 = {};
    Map data = {};
    int count = parseInt(cartList[i].qty);
    setState(() {
      count++;
      cartList[i].qty = count.toString();
      totalCount++;
    });
    data = {
      "add_to_cart": "1",
      "user_id": curUserId,
      "product_id": cartList[i].productId,
      "product_variant_id": cartList[i].productDetails![0].variants![0].id,
      "qty": cartList[i].qty,
    };
    callApi("manage_cart", data, "",i);
  }

  void removeCart(i) {
    Map data1 = {};
    Map data = {};
    int count = parseInt(cartList[i].qty);
    if (count == 1) {
      setState(() {
        count--;
        cartList[i].qty = count.toString();
        totalCount--;
      });

      data1 = {
        "remove_from_cart": "1",
        "user_id": curUserId,
        "qty": cartList[i].qty,
        "product_variant_id": cartList[i].productDetails![0].variants![0].id,
      };
      callApi("manage_cart", data1, "remove",-1);
    } else {
      setState(() {
        count--;
        cartList[i].qty = count.toString();
        totalCount--;
      });
      data1 = {
        "add_to_cart": "1",
        "user_id": curUserId,
        "product_id": cartList[i].productId,
        "product_variant_id": cartList[i].productDetails![0].variants![0].id,
        "qty": cartList[i].qty,
      };
      print("ok");
      callApi("manage_cart", data1, "",-1);
    }
  }

  void remove(i) {
    Map data;
    data = {
      "remove_from_cart": "1",
      "user_id": curUserId,
      "product_variant_id": cartList[i].productDetails![0].variants![0].id,
    //  "qty": cartList[i].qty,
    };

    callApi("remove_from_cart", data, "remove",-1);
  }

  void callApi(String url, Map data, String check,int i) async {
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        setState(() {
          loading = false;
        });
        Map response =
        await apiBase.postAPICall(Uri.parse(baseUrl + url), data);
        setState(() {
          loading = true;
        });
        if (!response['error']) {
          if(check=="remove"){
            getCart();
          }else{
            getTotal();
          }

        } else {
          if(i!=-1){
            int count = parseInt(cartList[i].qty);
            setState(() {
              count--;
              cartList[i].qty = count.toString();
              totalCount--;
            });

          }
          setSnackbar(response['message'], context);
        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = true;
        });
      }
    } else {
      setSnackbar("No Internet Available", context);
    }
  }

  Future<bool> backContext() async {
    Navigator.pop(context, totalCount != currentCount ? "refresh" : "");
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff15654F),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff15654F),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "assets/images/newbackss.png",
              height: 80,
            ),
          ),
          title: Text(
            "My Cart",
            style: TextStyle(
              color: Color(0xffF3F3F3),
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
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
      body: WillPopScope(
        onWillPop: backContext,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
              child: Column(
                children: [
                  boxHeight(20),
                  // Container(
                  //     width: getWidth(350),
                  //     child: text("My Cart",
                  //         fontSize: 14.sp, fontFamily: fontBold,isCentered: true)),
                  // boxHeight(20),
                  loadingCart
                      ? cartList.length > 0
                      ? ListView.builder(
                      itemCount: cartList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CartProductView(
                            cartList[index],
                                () {
                              setState(() {
                                currentIndex = index;
                              });
                              removeCart(index);
                            },
                                () {
                              setState(() {
                                currentIndex = index;
                              });
                              addCart(index);
                            },
                                () {},
                                () {
                              setState(() {
                                currentIndex = index;
                              });
                              remove(index);
                            },
                            currentIndex == index ? loading : true);
                      })
                      : Container(
                    height: getHeight(600),
                    child: Center(
                      child: text("No Items Available"),
                    ),
                  )
                      : Container(
                    height: getHeight(600),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: MyColorName.primaryDark,
                      ),
                    ),
                  ),
                  boxHeight(35),
                  priceView(),
                  boxHeight(40),
                  InkWell(
                    onTap: () {
                      navigateScreen(context, OrderConfirm2(gramValue: "",));
                    },
                    child: Container(
                      width: getWidth(320),
                      height: getHeight(50),
                      decoration: boxDecoration(
                          radius: 48, bgColor: MyColorName.primaryDark),
                      child: Center(
                        child: text(
                          "Proceed To Buy ( $totalCount Items )",
                          fontFamily: fontMedium,
                          textColor: Colors.black,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                  boxHeight(120),
                  cartList.length < 2 ? boxHeight(400) : boxHeight(10),
                ],
              ),
            ),
          ),
        ),
      ),);
  }
  priceView() {
    return Container(
      width: getWidth(624),
      decoration: boxDecoration(
        radius: 15,
        bgColor: MyColorName.colorTextFour.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(29), vertical: getHeight(32)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Sub Total",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹$subTotal",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight(22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Delivery Charges",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹$deliveryCharge",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight(proDiscount>0?22:0),
          proDiscount>0?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Pro Discount",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "-₹$proDiscount",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ):SizedBox(),
          boxHeight(22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Tax",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹$tax",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight(22),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Total",
                fontSize: 10.sp,
                fontFamily: fontSemibold,
              ),
              text(
                "₹$totalAmount",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
