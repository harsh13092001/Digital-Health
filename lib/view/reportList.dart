import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/view/cart.dart';
import 'package:digital_health/view/home.dart';
import 'package:digital_health/view/search.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:quantity_input/quantity_input.dart';

class ReportListPage extends StatefulWidget {
  @override
  _ReportListPageState createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
  @override

  Widget reportList() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection("medicines").where("isMedicine",isEqualTo: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ExpandableListReport(
                    snapshot.data.documents[index].data["name"],
                    snapshot.data.documents[index].data["company"],
                    snapshot.data.documents[index].data["price"],
                    snapshot.data.documents[index].data["discount"],
                    snapshot.data.documents[index].data["description"],
                  );
                });
          } else {
            return Container();
          }
        });
  }
  void initState() {
    super.initState();
  }
  Future<bool> _onBackPressed() {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(
        builder: (context) => medicalStore()));
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
                title: Text('Lab Reports & Test'),
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
                  })
                ],
              ),
              body : Container(child: reportList()),
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
                        MaterialPageRoute(builder: (context) => ReportListPage()));
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



class ExpandableListReport extends StatefulWidget {
  final String name;
  final String company;
  final int price;
  final int discount;
  final String description;
  ExpandableListReport(this.name, this.company,this.price,this.discount,this.description);

  @override
  _ExpandableListReportState createState() => _ExpandableListReportState();
}

class _ExpandableListReportState extends State<ExpandableListReport> {
  int simpleIntInput = 0;

  @override
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  Widget build(BuildContext context) {
    double discountPrice= widget.price - widget.price*(widget.discount/100);
    int originalPrice=discountPrice.toInt();
    bool ok=false;
    return Container(
      color: Colors.grey[350],
      padding: EdgeInsets.fromLTRB(2, 0, 2, 1),
      child: Card(
        child: ExpansionTileCard(
          key: cardA,
          initiallyExpanded: ok,
          leading: Container(
            height: 80.0,
            width: 50.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/download1.jpg'),
                fit: BoxFit.contain,
              ),
              shape: BoxShape.circle,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
              ),
              Text(
                widget.description,
                style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500,fontSize: 15),
              ),
              Text(
                "By: "+widget.company,
                style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500,fontSize: 13),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "\$"+originalPrice.toString()+".00",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 19),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "MRP:"+widget.price.toString() ,
                        style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w600,fontSize: 14),
                      ),
                      Text(
                        widget.discount.toString()+"\%"+" OFF",
                        style: TextStyle(color: Colors.green[600],fontWeight: FontWeight.w600,fontSize: 17
                        ),
                      )],
                  ),
                ],
              ),
            ],
          ),
          // subtitle: Text('I expand'),
          children: <Widget>[
            Divider(
              thickness: 1.0,
              height: 1.0,
            ),
            // Container(
            //   color: Colors.lightBlueAccent,
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    QuantityInput(
                        minValue: 0,
                        buttonColor: Colors.green[600],
                        value: simpleIntInput,
                        onChanged: (value) => setState(() => simpleIntInput = int.parse(value.replaceAll(',', '')))
                    ),
                    Text(
                        'Quantity: $simpleIntInput',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                ),
                ElevatedButton(
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(color: Colors.purpleAccent))),
                  ),
                  onPressed: () {
                    if (simpleIntInput == 0) {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => ReportListPage()));
                    }
                    else {
                      Map<String, dynamic>productMap = new Map<String,
                          dynamic>();
                      productMap = {
                        "company": widget.company,
                        "name": widget.name,
                        "discount": widget.discount,
                        "price": widget.price,
                        "isMedicine": true,
                        "quantity": simpleIntInput,
                        "description": widget.description,
                      };
                      Firestore.instance.collection("user").document(
                          userInfo.userPhoneNumber).collection("cart").add(
                          productMap);
                      userInfo.totalCart += (originalPrice * simpleIntInput);
                      Firestore.instance.collection("user").document(
                          userInfo.userPhoneNumber).updateData(
                          {"totalCart": userInfo.totalCart});
                      setState(() {
                        simpleIntInput = 0;
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => ReportListPage()));
                      });
                    }
                  }
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
