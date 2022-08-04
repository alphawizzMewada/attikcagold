import 'dart:async';

import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/myCart.dart';
import 'package:atticadesign/Helper/productDetailsDialog.dart';
import 'package:atticadesign/Model/category_model.dart';
import 'package:atticadesign/Model/productDetails_model.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/String.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/orderconfirm2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../Utils/ApiBaseHelper.dart';
import '../Utils/constant.dart';

class ProductDetails extends StatefulWidget {
  ProductModel model;

  ProductDetails(this.model);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool fav = false;
  addFav(vId) async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "product_id": vId,
          "user_id": curUserId,
        };
        Map response = await apiBase.postAPICall(
            Uri.parse(baseUrl + "add_to_favorites"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          fav = false;
        });
        setSnackbar(msg, context);
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          fav = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        fav = false;
      });
    }
  }
  void addCart() {
    Map data1 = {};
    Map data = {};
    int count = parseInt(widget.model.variants![0].cartCount);
    /*if(count>=parseInt(productList[i].variants![0].stock)){
      setSnackbar("Only ${productList[i].variants![0].stock} Stock Available", context);
      return;
    }*/
    setState(() {
      //count++;
      widget.model.variants![0].cartCount = count.toString();

    });
    data = {
      "add_to_cart": "1",
      "user_id": curUserId,
      "product_id": widget.model.variants![0].id,
      "product_variant_id":widget.model.variants![0].id,
      "qty": widget.model.variants![0].cartCount,
    };
    callApi("manage_cart", data,0);
  }
  bool loading = true;
  void callApi(String url, Map data,int i) async {
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCart()),
          );
        } else {
          /*if(i!=-1){
            int count = parseInt(productList[i].variants![0].cartCount);
            count--;
            productList[i].variants![0].cartCount = count.toString();
            totalCount--;

            setSnackbar(response['message'], context);
          }*/

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
  @override
  Widget build(BuildContext context) {
    var add;
    var _n = 0;
    var minus;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value();
      },
      child: Scaffold(
          backgroundColor: Color(0xFF004B3F),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFF15654F),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Image.asset(
                "assets/images/newbackss.png",
                height: 10,
                width: 10,
              ),
            ),
            title: Text(
              "Product Details",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyCart()));
                },
                child: Image.asset(
                  "assets/images/shop.png",
                  height: 20,
                  width: 20,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  "assets/images/well.png",
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffF1D459), Color(0xffB27E29)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: getHeight(70),
            width: getWidth(390),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: getHeight(85),
                  width: getWidth(140),
                  child: OutlinedButton(
                    onPressed: () {
                      if(widget.model.variants![0].cartCount=="0"){
                        widget.model.variants![0].cartCount="1";
                      }
                      addCart();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),
                    child: loading?const Text(
                      "ADD TO CART",
                      style: TextStyle(color: Color(0xff0F261E)),
                    ):CircularProgressIndicator(color: Colors.black,),
                  ),
                ),
                boxWidth(20),
                Container(
                  height: getHeight(85),
                  width: getWidth(140),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderConfirm2(gramValue: widget.model.weight.toString(),)),
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffF1D459), Color(0xffB27E29)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "BUY NOW",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff004B3F), fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  commonHWImage(widget.model.image, 258.00, 350.0, "", context,
                      "assets/homepage/gold.png"),
                  Positioned(
                    top: getHeight(10),
                    right: getWidth(20),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          widget.model.isFavorite = 1;
                        });
                        addFav(widget.model.id);
                      },
                      child: Container(
                        decoration: boxDecoration(
                          radius: 100,
                          bgColor: Color(0xff004B3F),
                        ),
                        width: getWidth(50),
                        height: getWidth(50),
                        padding: EdgeInsets.all(getWidth(5)),
                        child: Center(
                            child: !fav
                                ? Icon(
                                    widget.model.isFavorite.toString() == "1"
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Color(0xffF1D459))
                                : CircularProgressIndicator(
                                    color: Color(0xffF1D459),
                                  )),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(getWidth(10)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xff15654F), Color(0xff0F261E)],
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Text(
                        "gold ${widget.model.weight} gm ",
                        style: TextStyle(color: Color(0xffF1D459)),
                      ),
                      trailing: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                                text: '${widget.model.rating}   ',
                                style: TextStyle(color: Colors.white)),
                            WidgetSpan(
                                child: Image.asset(
                              "assets/images/star.png",
                              height: 20,
                            )),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "₹${widget.model.price}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                width: 150,
                              ),
                              Text(
                                "Weight ${widget.model.weight} gram",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "(Based on latest gold price)",
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product Id",
                                      style:
                                          TextStyle(color: Color(0xffF1D459)),
                                    ),
                                    boxHeight(8),
                                    Text(
                                      "${widget.model.id}",
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: getWidth(152),
                                  decoration: boxDecoration(
                                    radius: 10,
                                    bgColor: Color(0xff0BA84A),
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          int i = parseInt(widget
                                              .model.variants![0].cartCount
                                              .toString());
                                          if (i != 0) {
                                            setState(() {
                                              i--;
                                              widget.model.variants![0]
                                                  .cartCount = i.toString();
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: getHeight(49),
                                          width: getWidth(49),
                                          decoration: boxDecoration(
                                            radius: 10,
                                            bgColor: Color(0xff0BA84A),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              size: 24.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          height: getHeight(49),
                                          width: getWidth(49),
                                          decoration: boxDecoration(
                                            bgColor: MyColorName.colorBg1,
                                            radius: 0,
                                          ),
                                          child: Center(
                                            child: text(
                                                widget.model.variants![0]
                                                    .cartCount
                                                    .toString(),
                                                fontFamily: fontBold,
                                                fontSize: 12.sp,
                                                textColor: MyColorName
                                                    .colorTextPrimary),
                                          )),
                                      InkWell(
                                        onTap: () {
                                          int i = parseInt(widget
                                              .model.variants![0].cartCount
                                              .toString());
                                          setState(() {
                                            i++;
                                            widget.model.variants![0]
                                                .cartCount = i.toString();
                                          });
                                        },
                                        child: Container(
                                          height: getHeight(49),
                                          width: getWidth(49),
                                          decoration: boxDecoration(
                                            radius: 10,
                                            bgColor: Color(0xff0BA84A),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              size: 24.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(color: Color(0xffF1D459)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${widget.model.shortDescription}",
                            style: TextStyle(color: Colors.white54),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Delivery Details",
                          style: TextStyle(color: Color(0xffF1D459))),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                children: [
                                  WidgetSpan(
                                      child: Image.asset(
                                    "assets/images/car.png",
                                    height: 20,
                                  )),
                                  TextSpan(
                                      text: ' Delivery in 7-8 days ',
                                      style: TextStyle(color: Colors.white54)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                children: [
                                  WidgetSpan(
                                      child: Image.asset(
                                    "assets/images/eare.png",
                                    height: 20,
                                  )),
                                  TextSpan(
                                      text: '   Order Help and support ',
                                      style: TextStyle(color: Colors.white54)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                children: [
                                  WidgetSpan(
                                      child: Image.asset(
                                    "assets/images/right.png",
                                    height: 20,
                                  )),
                                  TextSpan(
                                      text: '   Secure packaging ',
                                      style: TextStyle(color: Colors.white54)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                children: [
                                  WidgetSpan(
                                      child: Image.asset(
                                    "assets/images/box.png",
                                    height: 20,
                                  )),
                                  TextSpan(
                                      text: '   No return is allowed ',
                                      style: TextStyle(color: Colors.white54)),
                                ],
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
                      color: Color(0xff14644E),
                      child: ExpansionTile(
                        backgroundColor: Color(0xFF666666),
                        // title: ,

                        childrenPadding: const EdgeInsets.all(8.0),
                        // leading: Text("Introduction"),

                        title: Text(
                          'Customer reviews  ',
                          style: TextStyle(color: Color(0xffF1D459)),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              "4.5 Out Of 5  ",
                              style: TextStyle(color: Colors.white),
                            ),
                            RatingBar.builder(
                              initialRating: 4.5,
                              itemSize: 20.0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                            // Image.asset("assets/payNow/star.png",height: 20,),
                          ],
                        ),

                        children: [
                          ListTile(
                            leading: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '26 reviews',
                                      style: TextStyle(
                                          decorationColor: Colors.yellow,
                                          decoration: TextDecoration.underline,
                                          color: Colors.white))
                                ],
                              ),
                            ),
                            trailing: Expanded(
                                child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyCart()),
                                );
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side:
                                          BorderSide(color: Color(0xffffffff))),
                                ),
                              ),
                              child: const Text(
                                "Write a review",
                                style: TextStyle(color: Color(0xff25FC98)),
                              ),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/james.png",
                                  height: 50,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "James Walk",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: RatingBar.builder(
                                        initialRating: 4,
                                        itemSize: 15.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Text(
                                    "5",
                                    style: TextStyle(color: Color(0xffFF5400)),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/images/likes.png",
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(color: Color(0xffFF5400)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/images/dislike.png",
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consetetur "
                              "sadipscing elitr, sed diam nonumy eirmod tem",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.white54,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/jamesss.png",
                                  height: 50,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "James Walk",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: RatingBar.builder(
                                        initialRating: 4,
                                        itemSize: 15.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Text(
                                    "5",
                                    style: TextStyle(color: Color(0xffFF5400)),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/images/likes.png",
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(color: Color(0xffFF5400)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/images/dislike.png",
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consetetur "
                              "sadipscing elitr, sed diam nonumy eirmod tem",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.white54,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/jamess.png",
                                  height: 50,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "James Walk",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: RatingBar.builder(
                                        initialRating: 4,
                                        itemSize: 15.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Text(
                                    "5",
                                    style: TextStyle(color: Color(0xffFF5400)),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/images/likes.png",
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(color: Color(0xffFF5400)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/images/dislike.png",
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consetetur "
                              "sadipscing elitr, sed diam nonumy eirmod tem",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.white54,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/jamesss.png",
                                  height: 50,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "James Walk",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: RatingBar.builder(
                                        initialRating: 4,
                                        itemSize: 15.0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Text(
                                    "5",
                                    style: TextStyle(color: Color(0xffFF5400)),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/images/likes.png",
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(color: Color(0xffFF5400)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  "assets/images/dislike.png",
                                  height: 20,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consetetur "
                              "sadipscing elitr, sed diam nonumy eirmod tem",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      var currentIndex;
      if (currentIndex == i) {
        // print("count:: "+currentIndex.toString());
        var currentIndex;
        if (currentIndex == 3) {
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Color(0XffF1D459),
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        } else {}
      } else {}
    }

    return indicators;
  }
}
