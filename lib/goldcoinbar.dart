import 'dart:async';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/myCart.dart';
import 'package:atticadesign/Helper/productDetails.dart';
import 'package:atticadesign/Helper/wishlist.dart';
import 'package:atticadesign/Model/GetGoldCoinModel.dart';
import 'package:atticadesign/Model/category_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Api/api.dart';
import 'HomePage.dart';
import 'Utils/String.dart';

class GoldCoinBar extends StatefulWidget {

  const GoldCoinBar({Key? key}) : super(key: key);

  @override
  State<GoldCoinBar> createState() => _GoldCoinBarState();
}

class _GoldCoinBarState extends State<GoldCoinBar> {
  String type = "48";

   @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getCategory();
   // getProduct("54");
  }
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  List<CategoryModel> catList = [];
  List<ProductModel> productList = [];
  getCategory() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
        };
        Map response =
        await apiBase.postAPICall(Uri.parse(baseUrl + "get_categories"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setSnackbar(msg, context);
        if(!response['error']){
          for(var v in response['data']){
            setState(() {
              catList.add(new CategoryModel.fromJson(v));
            });
          }
          if(catList.length>0){
            getProduct(catList[0].id);
          }
        }else{

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        loading = false;
      });
    }
  }

  getProduct(catId) async {
    await App.init();
    setState(() {
      loading = true;
    });
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "category_id":catId,
          "user_id": curUserId,
        };
        Map response =
        await apiBase.postAPICall(Uri.parse(baseUrl + "get_products"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          loading = false;
          productList.clear();
        });
        setSnackbar(msg, context);
        if(!response['error']){
          for(var v in response['data']){
            setState(() {
              productList.add(new ProductModel.fromJson(v));
            });
          }
        }else{

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        loading = false;
      });
    }
  }
  bool fav  = false;
  addFav(vId) async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "product_id":vId,
          "user_id": curUserId,
        };
        Map response =
        await apiBase.postAPICall(Uri.parse(baseUrl + "add_to_favorites"), data);
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
  String tapIndex = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff15654F),
          leading: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomBar()),
              );
            },
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/newbackss.png',height: 30,),
            ),
          ),
          title: Text(
            "Gold Coin/Bar",
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
                      MaterialPageRoute(builder: (context) => Wishlist()),
                    );
                  },
                    child: Icon(Icons.favorite_border, color: Color(0xffF1D459))),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyCart()));
                    },
                    child: Icon(Icons.shopping_cart_rounded, color: Color(0xffF1D459))),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.notifications_active,
                      color: Color(0xffF1D459)),
                ),
              ],
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
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
                          child: InkWell(
                            onTap: (){
                              int index = catList.indexWhere((element) => element.name!.toLowerCase()=="gold");
                              if(index!=-1){
                                getProduct(catList[index].id);
                              }
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
                              int index = catList.indexWhere((element) => element.name!.toLowerCase()=="silver");
                              if(index!=-1){
                                getProduct(catList[index].id);
                              }

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
                // SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text('Available Item',style: TextStyle(
                          color: Colors.white,fontSize: 15,
                        ),),
                      ),
                      // Row(
                      //   children: [
                      //     Image.asset('assets/buydigitalgold/filter.png',color: Colors.white,height: 15,),
                      //     SizedBox(width: 10,),
                      //     Text('Filters',style: TextStyle(
                      //       color: Colors.white,fontSize: 15,
                      //     ),)  ,
                      //   ],
                      // ),
                    ],
                  ),
                ),
                boxHeight(10),
                Expanded(
                  child: !loading?productList.length>0?Container(
                    width: getWidth(350),
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: getWidth(20),
                    crossAxisSpacing: getHeight(20),
                    children: productList.map((ProductModel model){
                      return InkWell(
                        onTap: ()async{
                          var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(model)));
                          if(result){
                            int index = catList.indexWhere((element) => element.name!.toLowerCase()=="gold");
                            if(index!=-1){
                              getProduct(catList[index].id);
                            }
                          }
                        },
                        child: Container(
                          decoration: boxDecoration(
                            radius: 24.sp,
                            bgColor: Color(0xff004B3F),
                          ),
                          child: Column(
                            children: [
                              boxHeight(10),
                              commonHWImage(model.image, 118.00, 118.00, "", context, "assets/homepage/gold.png"),
                              boxHeight(10),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal:getWidth(8)),
                                  decoration: boxDecoration(
                                    radius: 24.sp,
                                    bgColor: Color(0xff15654F),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      boxHeight(5),
                                      text(
                                        getString1(model.name.toString()),
                                        fontFamily: fontMedium,
                                        fontSize: 9.sp
                                      ),
                                      boxHeight(5),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            text(
                                                "₹ "+getString1(model.price.toString()),
                                                fontFamily: fontMedium,
                                                fontSize: 12.sp,
                                              textColor: Color(0xffF1D459),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                setState(() {
                                                  fav = true;
                                                  model.isFavorite = 1;
                                                  tapIndex = model.id.toString();
                                                });
                                                addFav(model.id);
                                              },
                                              child: Container(
                                                decoration: boxDecoration(
                                                  radius: 100,
                                                  bgColor: Color(0xff004B3F),
                                                ),
                                                  padding: EdgeInsets.all(getWidth(5)),
                                                  child: Center(child: !fav||tapIndex != model.id.toString()?Icon(model.isFavorite.toString()=="1"?Icons.favorite:Icons.favorite_border, color: Color(0xffF1D459)):
                                                  CircularProgressIndicator(color: Color(0xffF1D459),)
                                                  )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),),
                  ):Center(
                    child: text("No Product Available",fontSize: 14.sp,textColor: Color(0xffF1D459)),
                  ):Center(child: CircularProgressIndicator(color:Color(0xffF1D459),),),
                )
              ]),
        ));
  }


}
