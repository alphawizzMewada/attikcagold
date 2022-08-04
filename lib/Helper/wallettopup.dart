import 'package:atticadesign/Helper/transation_mode.dart';
import 'package:atticadesign/transaction.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../Utils/Common.dart';
import '../Utils/Razorpay.dart';
import 'myLocker.dart';

class WalletTopups extends StatefulWidget {
  const WalletTopups({Key? key}) : super(key: key);

  @override
  State<WalletTopups> createState() => _WalletTopupsState();
}

class _WalletTopupsState extends State<WalletTopups> {
  List categories = [
    " ₹ 1000 ",
    " ₹ 2000 ",
    " ₹ 5000 ",
  ];
  List selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F261E),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF15654F),
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyLocker()),
            );
          },
          child: Image.asset(
            "assets/images/newbackss.png",
            height: 8,
            width: 8,
          ),
        ),
        title: Text("Wallet Topup"),
        actions: [
          Image.asset(
            "assets/images/shop.png",
            height: 15,
            width: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              "assets/images/well.png",
              height: 15,
              width: 20,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Topup wallet",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

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
                    hintText: "₹ Enter Amount",

                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: '₹ Enter Amount',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,

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

                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,

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
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                RazorPayHelper razorHelper=new RazorPayHelper(choiceAmountController.text, context, (result){
                  if(result=="error"){

                  }else{

                  }
                },App.localStorage.getString("userId").toString(),"",false,false);
                razorHelper.init();
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffF1D459), Color(0xffB27E29)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  height: 45,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Text(
                      "PROCEED TO TOPUP",
                      style: TextStyle(color: Color(0xff004B3F), fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Text(
                "Recent wallet transaction",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Transaction()),
                  );
                },
                child: Text(
                  "View All",
                  style: TextStyle(color: Color(0xffF1D459), fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            FutureBuilder(
                future: getTransationCash(
                  App.localStorage.getString("userId").toString(),
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    TransationModeOnlyAmount? transationModel = snapshot.data;

                    return transationModel!.data!.length > 0
                        ? Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: transationModel.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Color(0xff24745E),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  leading: Image.asset(
                                      "assets/images/lockercupan.png"),
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6),
                                    child: Text(
                                      "${transationModel.data![0].message}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18),
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                              "${transationModel.data![0].dateCreated}",
                                              style: TextStyle(
                                                  color:
                                                  Colors.white54)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  trailing: Text(
                                    "₹ ${transationModel.data![0].amount}",
                                    style: TextStyle(
                                        color: Color(0xffF1D459),
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                        : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        child: Center(
                            child: Text(
                              "No History Yet",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22),
                            )));
                  }
                  else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ));
                  }
                })
          ],
        ),
      ),
    );
  }

  TextEditingController choiceAmountController = TextEditingController();
}
