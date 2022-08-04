import 'package:atticadesign/Helper/couponCode.dart';
import 'package:atticadesign/selldigitalgold.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'buydigitalgold.dart';
import 'notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();

  get child => null;

  get imageSliders => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primary.withOpacity(0.5),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.9,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/homepage/Rectangledark.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.centerRight,
                  // width: 380,
                  height: 230,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, bottom: 80, top: 16),
                          child: Image.asset(
                            'assets/homepage/digitalgold.png',
                            height: 120,
                            width: 100,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 80.0,
                            ),
                            child: Container(
                              margin: EdgeInsets.only(top: 20, left: 20),
                              height: 60,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Color(0xff24745E),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10.0),
                                    child: Text(
                                      'Gold Buy Price',
                                      style: TextStyle(
                                        color: Color(0xffF3F3F3),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '₹ 5362.39/gm',
                                    style: TextStyle(
                                      color: Color(0xffF1D459),
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotiPage()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                alignment: AlignmentDirectional.topCenter,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NotiPage()),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/homepage/ring.png',
                                    height: 120,
                                    width: 110,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 130.0, left: 5, right: 5),
                  child: Container(
                    height: 150,
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff24745E),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20),
                              child: Image.asset(
                                'assets/homepage/goldbrick.png',
                                height: 70,
                                width: 100,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20.0, top: 30),
                              child: Text(
                                '0.0000gm',
                                style: TextStyle(
                                  color: Color(0xff0C3B2E).withOpacity(0.3),
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Own digital gold',
                                style: TextStyle(
                                  color: Color(0xffF3F3F3),
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '99.99K Pure Gold',
                                style: TextStyle(
                                  color: Color(0xffF1D459),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Offer For You',
              style: TextStyle(
                color: Color(0xffF3F3F3),
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  viewportFraction: 1.1,
                  enlargeCenterPage: true,
                ),
                items: [Container(child: Image.asset("assets/images/1.png"))]),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Text(
          //     'Start Your investment Journey',
          //     style: TextStyle(
          //       color: Color(0xffF3F3F3),
          //       fontSize: 18,
          //     ),
          //   ),
          // ),
          // Container(
          //   height: 130,
          //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Color(0xff24745E),
          //     borderRadius: BorderRadius.all(Radius.circular(10)),
          //   ),
          //   child: Column(
          //     children: [
          //       Padding(
          //         padding:
          //             const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Text(
          //               '₹ 10.00',
          //               style: TextStyle(
          //                 color: Color(0xff15654F),
          //                 fontSize: 40,
          //               ),
          //             ),
          //             Container(
          //               height: 50,
          //               width: 120,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(35.0),
          //                 gradient: LinearGradient(
          //                     colors: [
          //                       Color(0xffF1D459),
          //                       Color(0xffB27E29),
          //                     ],
          //                     begin: Alignment.topCenter,
          //                     end: Alignment.bottomCenter),
          //               ),
          //               child: Center(
          //                   child: Text(
          //                 "Invest Now",
          //                 style: TextStyle(
          //                     color: Color(0xff0C3B2E),
          //                     fontWeight: FontWeight.bold),
          //               )),
          //             ),
          //           ],
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               'But Digital Gold With ',
          //               style: TextStyle(
          //                 color: Color(0xffF3F3F3),
          //                 fontSize: 15,
          //               ),
          //             ),
          //             Text(
          //               '₹ 10',
          //               style: TextStyle(
          //                 color: Color(0xffF1D459),
          //                 fontSize: 15,
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Container(
            height: 200,
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/homepage/offer.png',
                  ),
                  fit: BoxFit.contain,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20.0, top: 45, left: 2),
                      child: Text(
                        'Have Coupon Code',
                        style:
                            TextStyle(color: Color(0xffF1D459), fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 15),
                      child: Text(
                        'Redeem to get Free gold',
                        style:
                            TextStyle(color: Color(0xffF3F3F3), fontSize: 10),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CouponCode()),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xffF1D459),
                                  Color(0xffB27E29),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Center(
                              child: Text(
                            "Get Now",
                            style: TextStyle(color: Color(0xff0C3B2E)),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/homepage/scooter.png',
                  ),
                  fit: BoxFit.fill,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 30.0, top: 20, left: 15),
                      child: Text(
                        'Gold Delivery',
                        style:
                            TextStyle(color: Color(0xffF1D459), fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 30.0),
                      child: Text(
                        'Get 24k 99.99% pure Gold Items \n delivered at your home',
                        style:
                            TextStyle(color: Color(0xffF3F3F3), fontSize: 10),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                            colors: [
                              Color(0xffF1D459),
                              Color(0xffB27E29),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                      child: Center(
                          child: Text(
                        "Get Now",
                        style: TextStyle(color: Color(0xff0C3B2E)),
                      )),

                      // child: Padding(
                      //   padding: EdgeInsets.only(top: 10,bottom: 10,left: 55),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(builder: (context) =>  CouponCode()),
                      //         );
                      //
                      //     },
                      //     child: Text(
                      //       'Get Now',
                      //       style: TextStyle(
                      //           color: Color(0xff0C3B2E), fontSize: 15),
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(40),
                      //       ),
                      //       padding: EdgeInsets.all(20),
                      //       // primary: Color(0xffF1D459), // <-- Button color
                      //       // onPrimary: Color(0xffB27E29), // <-- Splash color
                      //     ),
                      //   ),
                      // ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      )),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          Container(
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyDigitalGold()),
                );
              },
              child: Center(
                child: Image.asset(
                  'assets/homepage/buy.png',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SellDigitalGold()),
                );
              },
              child: Image.asset('assets/homepage/sell.png'),
            ),
          ),
        ],
      ),
    );
  }
}
