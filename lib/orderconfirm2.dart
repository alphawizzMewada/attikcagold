import 'dart:async';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/paynow.dart';
import 'package:atticadesign/Model/address_model.dart';
import 'package:atticadesign/Model/voucher_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/screen/voucher_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'screen/address_list_view.dart';

class OrderConfirm2 extends StatefulWidget {
  final String gramValue;

  const OrderConfirm2({Key? key, required this.gramValue}) : super(key: key);

  @override
  State<OrderConfirm2> createState() => _OrderConfirm2State();
}

class _OrderConfirm2State extends State<OrderConfirm2> {
  TextEditingController controller = new TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  VoucherModel? model;
  bool loading = true;
  String selectTime = "Schedule Delivery time";
  double subTotal = 0,
      deliveryCharge = 0,
      tax = 0,
      totalAmount = 0,
      tempTotal = 0,
      proDiscount = 0;
  double? voucher;

  getTotal() async {
    try {
      Map params = {
        "get_user_cart": "1",
        "user_id": curUserId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_user_cart"), params);
      setState(() {
        loading = true;
      });
      if (!response['error']) {
        setState(() {
          subTotal = double.parse(response['sub_total'].toString());
          if (response['delivery_charge'] != null) {
            deliveryCharge =
                double.parse(response['delivery_charge'].toString());
          }
          if (response['tax_amount'] != null) {
            tax = double.parse(response['tax_amount'].toString());
          }

          totalAmount = subTotal + deliveryCharge + tax;
          tempTotal = totalAmount;
        });
      } else {}
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }

  addVoucher(total, promoCode, model1) async {
    try {
      Map params = {
        "validate_promo_code": "1",
        "user_id": curUserId.toString(),
        "final_total": subTotal.toString(),
        "promo_code": promoCode.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "validate_promo_code"), params);

      if (!response['error']) {
        setState(() {
          model = model1;
          voucher =
              double.parse(response['data'][0]['final_discount'].toString());
          totalAmount =
              double.parse(response['data'][0]['final_total'].toString()) +
                  deliveryCharge +
                  tax;
        });
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

  bool saveStatus = true;
  List<String> typeList = ["Home", "Office", "Other"];
  String? selectType;
  List<AddModel> addressList = [];

  getAddress() async {
    try {
      setState(() {
        curIndex = null;
        selectType = null;
        addressList.clear();
        saveStatus = false;
      });
      Map params = {
        "get_addresses": "1",
        "user_id": curUserId.toString(),
      };
      Map response =
          await apiBase.postAPICall(Uri.parse(baseUrl + "get_address"), params);
      setState(() {
        saveStatus = true;
      });
      if (!response['error']) {
        for (var v in response['data']) {
          setState(() {
            if (v['type'] != "") {
              addressList.add(new AddModel.fromJson(v));
            }
          });
        }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
    getTotal();
    //generateTimeSlot();
  }

  String? _dropDownValue;
  String _selectedMenu = '';
  final GlobalKey _menuKey = GlobalKey();
  double priceRange = 0;
  int? curIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF15654F),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff15654F),
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset("assets/images/newbackss.png")),
          title: Text(
            "Order Confirm",
            style: TextStyle(
              color: Color(0xffF3F3F3),
              fontSize: 20,
            ),
          ),
          /* actions: [
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
          ],*/
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: getWidth1(49)),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                'assets/homepage/vertical.png',
              ),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                boxHeight(40),
                Container(
                  decoration: boxDecoration(
                    bgColor: MyColorName.colorTextFour,
                    radius: 10,
                  ),
                  padding: EdgeInsets.all(getWidth1(10)),
                  child: DropdownButton<String>(
                    underline: SizedBox(),
                    iconSize: getHeight(40),
                    dropdownColor: MyColorName.colorTextFour,
                    isDense: true,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    iconEnabledColor: MyColorName.primaryDark,
                    value: selectType,
                    items: typeList.map((p) {
                      return DropdownMenuItem<String>(
                        value: p,
                        child: text(p,
                            fontSize: 12.sp,
                            fontFamily: fontMedium,
                            textColor: Colors.white),
                      );
                    }).toList(),
                    hint: text("Choose Address Type",
                        fontSize: 12.sp,
                        fontFamily: fontMedium,
                        textColor: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        selectType = value;
                        curIndex = null;
                      });
                      int i = addressList.indexWhere((element) =>
                          element.type!.toLowerCase() ==
                          selectType!.toLowerCase());
                      if (i != -1) {
                        setState(() {
                          curIndex = i;
                        });
                      } else {}
                    },
                  ),
                ),
                boxHeight(10),
                Container(
                  decoration: boxDecoration(
                    bgColor: MyColorName.colorTextFour,
                    radius: 10,
                  ),
                  padding: EdgeInsets.all(getWidth1(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: MyColorName.colorIcon,
                              ),
                              boxWidth(10),
                              text("Delivery Address",
                                  fontSize: 10.sp,
                                  fontFamily: fontMedium,
                                  textColor: Colors.white),
                            ],
                          ),
                          PopupMenuButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: Color(0xff15654F),
                            onSelected: (value) async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddressList(false, false)),
                              );
                              if (result) {
                                getAddress();
                              }
                            },
                            itemBuilder: (BuildContext bc) {
                              return const [
                                PopupMenuItem(
                                  child: InkWell(
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        "Edit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  value: 'Edit',
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      "Add",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  value: 'Add',
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.delete_forever,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  value: 'Delete',
                                )
                              ];
                            },
                          ),
                        ],
                      ),
                      boxHeight(5),
                      InkWell(
                        onTap: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddressList(false, false)),
                          );
                          if (result) {
                            getAddress();
                          }
                        },
                        child: text(
                            curIndex != null
                                ? addressList[curIndex!].address.toString()
                                : "Select Or Add Address",
                            fontSize: 10.sp,
                            fontFamily: fontMedium,
                            textColor: Colors.white),
                      ),
                      boxHeight(5),
                      Divider(),
                      TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          focusedBorder: InputBorder.none,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          prefixIcon: Container(
                            height: getHeight1(16),
                            width: getWidth1(16),
                            padding: EdgeInsets.all(getWidth1(10)),
                            child: Icon(
                              Icons.speaker_notes,
                              color: Colors.white,
                            ),
                          ),
                          label: text("Add Notes For Your Delivery",
                              fontFamily: fontRegular),
                        ),
                      )
                    ],
                  ),
                ),
                // boxHeight(10),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[
                //     Text(priceRange.toString()),
                //     new Container(
                //       padding: EdgeInsets.only(top: 20.0),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: <Widget>[],
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: new Container(
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(20.0),
                //             color: Color(0xff24745E)),
                //         padding: EdgeInsets.only(
                //             left: ((MediaQuery.of(context).size.width - 10) /
                //                     10) /
                //                 2,
                //             right: ((MediaQuery.of(context).size.width - 10) /
                //                     10) /
                //                 2),
                //         width: MediaQuery.of(context).size.width,
                //         child: new CupertinoSlider(
                //           thumbColor: Colors.orange,
                //           activeColor: Color(0xff24745E),
                //           value: priceRange,
                //           onChanged: (value) {
                //             setState(() {
                //               priceRange = value;
                //             });
                //           },
                //           max: 100,
                //           min: 0,
                //           divisions: 10,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "min",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //     SizedBox(
                //       width: 270,
                //     ),
                //     Text("max", style: TextStyle(color: Colors.white)),
                //   ],
                // ),
                // SizedBox(height: 40),
                boxHeight(35),
                voucherView(),
                model != null ? boxHeight(35) : SizedBox(),
                model != null ? promoCode() : SizedBox(),
                boxHeight(16),
                text(
                  "Your Cart Summary",
                  fontFamily: fontMedium,
                  fontSize: 14.sp,
                  textColor: MyColorName.primaryDark,
                ),
                boxHeight(16),
                priceView(),
                boxHeight(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: getWidth1(283),
                        height: getHeight1(85),
                        decoration: boxDecoration(
                            radius: 48,
                            bgColor: MyColorName.primaryDark,
                            color: MyColorName.primaryDark),
                        child: Center(
                          child: text("Cancel",
                              fontFamily: fontMedium,
                              fontSize: 10.sp,
                              textColor: MyColorName.colorTextPrimary),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (curIndex == null) {
                          setSnackbar("Please Select or Add Address", context);
                          return;
                        }
                        addressId = addressList[curIndex!].id.toString();
                        latitude = double.parse(
                            addressList[curIndex!].latitude.toString());
                        longitude = double.parse(
                            addressList[curIndex!].longitude.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PayNow(
                                  voucher,
                                  totalAmount,
                                  model,
                                  "",
                                  controller.text,
                                  subTotal + tax,
                                  "NotAvailable",
                                  deliveryCharge.toString(),
                                  widget.gramValue)),
                        );
                      },
                      child: Container(
                        width: getWidth1(283),
                        height: getHeight1(85),
                        decoration: boxDecoration(
                            radius: 48, bgColor: MyColorName.primaryDark),
                        child: Center(
                          child: text("Pay Now",
                              fontFamily: fontMedium,
                              fontSize: 22,
                              textColor: MyColorName.colorTextPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
                boxHeight(30),
              ],
            ),
          )),
        ));
  }

  promoCode() {
    return Container(
      width: getWidth1(622),
      decoration: boxDecoration(
        radius: 15,
        bgColor: MyColorName.colorTextFour.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth1(16), vertical: getHeight1(21)),
      child: Column(
        children: [
          Container(
              width: getWidth1(622),
              child: text("Applied Promo Code",
                  fontSize: 10.sp, fontFamily: fontRegular)),
          boxHeight(12),
          Container(
            width: getWidth1(500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(model!.promo_code,
                        textColor: MyColorName.primaryDark,
                        fontSize: 12.sp,
                        fontFamily: fontMedium),
                    text(model!.message,
                        textColor: MyColorName.primaryDark,
                        fontSize: 8.sp,
                        fontFamily: fontRegular),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      model = null;
                      voucher = null;
                      getTotal();
                    });
                  },
                  child: Container(
                    width: getWidth1(48),
                    height: getWidth1(48),
                    decoration: boxDecoration(
                        radius: 100, bgColor: MyColorName.primaryDark),
                    child: Center(
                        child: Icon(
                      Icons.close,
                      size: 20,
                      color: MyColorName.colorTextFour,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  priceView() {
    return Container(
      width: getWidth1(624),
      decoration: boxDecoration(
        radius: 15,
        bgColor: MyColorName.colorTextFour.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth1(29), vertical: getHeight1(32)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Sub Total (1Items)",
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
          voucher != null ? boxHeight(22) : SizedBox(),
          voucher != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(
                      "Voucher Discount",
                      fontSize: 10.sp,
                      fontFamily: fontRegular,
                    ),
                    text(
                      "-₹$voucher",
                      fontSize: 10.sp,
                      fontFamily: fontBold,
                    ),
                  ],
                )
              : SizedBox(),
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
          boxHeight(proDiscount > 0 ? 22 : 0),
          proDiscount > 0
              ? Row(
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
                )
              : SizedBox(),
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
                "₹${tax}",
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
                addVoucher(tempTotal, result.promo_code, result);
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
}
