import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/view/addProduct.dart';
import 'package:digital_health/view/cart.dart';
import 'package:digital_health/view/home.dart';
import 'package:digital_health/view/medicineList.dart';
import 'package:digital_health/view/reportList.dart';
import 'package:digital_health/view/search.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_health/model/user.dart';
import 'package:digital_health/view/generate.dart';
import 'package:digital_health/view/medicalStore.dart';
import 'package:digital_health/view/record.dart';
import 'package:digital_health/view/scan.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class medicalStore extends StatefulWidget {
  @override
  _medicalStoreState createState() => _medicalStoreState();
}

class _medicalStoreState extends State<medicalStore> {
  @override
  Future<bool> _onBackPressed() {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(
        builder: (context) => home()));
  }
  Widget build(BuildContext context) {
    int selectedIndex = 2;
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFFDB50FF),
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Color(0xFFDB50FF),
            title: Text('Medical Store'),
            actions: [
              IconButton(
                  icon: Icon(Icons.search), onPressed: (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => search()));
              }),
              IconButton(
                  icon: Icon(Icons.shopping_cart), onPressed: (){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => cart()));
              }),

            ],
          ),
      body:
      Column(
        children: [
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 2/1.3,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(4,//this is the total number of cards
                    (index){
                  if(index==1){
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => ReportListPage()));
                      },
                      child: Container(
                        child: Card(
                          color: Colors.indigo[50],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/download.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text("Laboratory Tests/Reports",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  else if (index==2){
                    return Container(
                      child: Card(
                        color: Colors.pink[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/download2.jpg'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text("Order Precreption",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    );
                  }
                  else if (index==3){
                    return  userInfo.userPhoneNumber=="+919484647425"? GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => addProduct()));
                      },
                      child: Container(
                        child: Card(
                          color: Colors.green[100],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/download4.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text("Add Products",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    ):Container(
                      child: Card(
                        color: Colors.green[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/download4.jpg'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text("More",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    );
                  }
                  else if (index==0){
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => medicineListPage()));
                      },
                      child: Container(
                        child: Card(
                          color: Colors.yellow[100],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 80.0,
                                width: 80.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/download1.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text("Medicines",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    );;
                  }
                }
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            color: Colors.grey[300],
            alignment: Alignment.centerLeft,
              child: Text("Special Deals & Offers",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
          Expanded(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/discount.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        shape: BoxShape.rectangle,
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage("assets/images/discount1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //3rd Image of Slider
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        shape: BoxShape.rectangle,
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage("assets/images/discount2.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  ],

                  //Slider Container properties
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.grey[300],
              alignment: Alignment.centerLeft,
              child: Text("Trending Products",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
          Expanded(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/medicine1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        shape: BoxShape.rectangle,
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage("assets/images/medicine2.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //3rd Image of Slider
                    Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        shape: BoxShape.rectangle,
                        color: Colors.grey,
                        image: DecorationImage(
                          image: AssetImage("assets/images/medicine3.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  ],

                  //Slider Container properties
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
          bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.black,
              selectedItemBorderColor: Color(0xFFFF00FB),
              selectedItemBackgroundColor: Colors.white,
              selectedItemIconColor: Colors.black,
              selectedItemLabelColor: Colors.white,
              barHeight: 70,
              itemWidth: 53,
            ),
            selectedIndex: selectedIndex,
            onSelectTab: (index) {
              if(index==0){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => record()));
              }
              else if(index==1){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => home()));
              }
              else if(index==2){
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => medicalStore()));
              }
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              // FFNavigationBarItem(
              //   iconData: Icons.camera,
              //   label: 'Schedule',
              // ),
              FFNavigationBarItem(
                iconData: Icons.list_alt_rounded,
                label: 'Health Card',
              ),
              FFNavigationBarItem(
                iconData: Icons.qr_code,
                label: 'QR Code',
              ),
              FFNavigationBarItem(
                iconData: Icons.medical_services_outlined,
                label: 'Medical Store',
              ),
            ],
          ),
    )));
  }
}