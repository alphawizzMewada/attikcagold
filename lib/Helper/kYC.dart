
import 'package:atticadesign/Helper/myAccount.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class KYC extends StatefulWidget {

  const KYC({Key? key}) : super(key: key);
  @override
  State<KYC> createState() => _KYCState();

}

class _KYCState extends State<KYC> {
  String? _dropDownValue;

  // late File sampleImage;
  // Future getImage() async {
  //   var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     sampleImage = tempImage;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0F261E),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF15654F),
        leading: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  MyAccount()),
            );
          },
          child: Image.asset(
            "assets/images/newbackss.png",
            height: 80,
            width: 80,
          ),
        ),
        title: Text("KYC"),
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
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 70,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
                color: Color(0xff24745E),
              ),
              child: Center(
                  child: Text(
                "KYC of your Address proof & Pan car is \npending please complete to buy gold ",
                style: TextStyle(color: Color(0xffF1D459), fontSize: 15),
              )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: DropdownButton<String>
                (
                  value: _dropDownValue,
                  // hint: Text("sadasdd", style: TextStyle(color: Colors.white)),
                  isExpanded: true,
                  underline: Container(
                    height: 1.0,
                    decoration: const BoxDecoration(



                        // border: Border(
                        //     bottom: BorderSide(
                        //         color: Color(0xFFBDBDBD),
                        //         width: 2))
                    ),
                    child: Text(
                      'Choose Your Delivery Location Type',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),

                dropdownColor: Color(0xff24745E),
                  // hint: _dropDownValue == null
                  //     ? Padding(
                  //   padding:
                  //   const EdgeInsets.only(left: 10.0),
                  //   child: Text(
                  //     'Choose Your Delivery Location Type',
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // )
                  //     : Text(
                  //   _dropDownValue!,
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  // isExpanded: true,
                  iconSize: 40.0,
                  iconEnabledColor: Colors.yellow,
                  //dropdownColor: Color(0xff24745E),
                  style: TextStyle(color: Colors.white),
                  items: ['Aadhar card', 'Driving Licence', 'Passport','Bank Passbook','Phone/Electricity Bill'].map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                          () {
                        _dropDownValue = val as String?;
                      },
                    );
                  }),
            ),
          ),



          // Padding(
       //   padding: const EdgeInsets.only(left: 12,right: 12),
       //   child: Image.asset("assets/images/dropdown.png"),
       // ),
      //  ExpandableTheme(
      //   data: const ExpandableThemeData(
      //     iconColor: Colors.blue,
      //     useInkWell: true,
      //   ),
      //   child: ListView(
      //     physics: const BouncingScrollPhysics(),
      //     children: <Widget>[
      //       // Card1(),
      //       // Card2(),
      //       // Card3(),
      //     ],
      //   ),
      // ),



          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "Aadhar card",
            style: TextStyle(color: Colors.white54, fontSize: 20),
          )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 280,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
                color: Color(0xff24745E),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff0C3B2E),
                              borderRadius: BorderRadius.circular(30.0)),
                          height: 50,
                          width: 320,
                          child: TextField(
                            maxLines: 1,
                            style: TextStyle(fontSize: 17),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                hintStyle: TextStyle(color: Color(0xffafaf7b).withOpacity(0.3)),
                                hintText: ("Enter Aadhar number")),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 70,
                        width: 325,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          color: Color(0xff0C3B2E),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              "assets/images/upload.png",
                              height: 20,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Aadhar Card (Front)",
                              style: TextStyle(color: Color(0xffF1D459)),
                            )
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 70,
                        width: 370,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          color: Color(0xff0C3B2E),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              "assets/images/upload.png",
                              height: 20,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Aadhar Card (Back)",
                              style: TextStyle(color: Color(0xffF1D459)),
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.white54,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "PAN card",
            style: TextStyle(color: Colors.white54, fontSize: 20),
          )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 180,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ),
                color: Color(0xff24745E),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff0C3B2E),
                              borderRadius: BorderRadius.circular(30.0)),
                          height: 50,
                          width: 320,
                          child: TextField(
                            maxLines: 1,
                            style: TextStyle(fontSize: 17),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                hintStyle: TextStyle(color: Color(0xffafaf7b).withOpacity(0.3)),
                                hintText: ("Enter PAN number")),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: 370,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        color: Color(0xff0C3B2E),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            "assets/images/upload.png",
                            height: 20,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "PAN Card (Front)",
                            style: TextStyle(color: Color(0xffF1D459)),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffF1D459),
                      Color(0xffB27E29)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                      30.0)),
              height: 50,
              width: 160,
              child: Center(child: Text("SAVE",style: TextStyle(
                  color: Color(0xff004B3F),
                  fontSize: 15),),),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

}

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    buildItem(String label) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(label),
      );
    }

    buildList() {
      return Column(
        children: <Widget>[
          for (var i in [1, 2, 3, 4]) buildItem("Item ${i}"),
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ScrollOnExpand(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: false,
                    ),
                    header: Container(
                      color: Colors.indigoAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            // ExpandableIcon(
                            //   theme: const ExpandableThemeData(
                            //     expandIcon: Icons.arrow_right,
                            //     collapseIcon: Icons.arrow_drop_down,
                            //     iconColor: Colors.white,
                            //     iconSize: 28.0,
                            //     iconRotationAngle: math.pi / 2,
                            //     iconPadding: EdgeInsets.only(right: 5),
                            //     hasIcon: false,
                            //   ),
                            // ),
                            Expanded(
                              child: Text(
                                "Items",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    collapsed: Container(),
                    expanded: buildList(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
