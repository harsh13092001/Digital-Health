import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/services/database.dart';
import 'package:digital_health/view/home.dart';
import 'package:digital_health/view/medicalStore.dart';
import 'package:digital_health/view/medicineList.dart';
import 'package:digital_health/view/record.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:digital_health/model/user.dart';

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  TextEditingController searchTextEditingcontroller =
  new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;
  QuerySnapshot snapshotUserInfo;
  initaiteSearch(){
    databaseMethods
        .getMedicineSearch(searchTextEditingcontroller.text.toLowerCase())
        .then((val) async {
      print(val.toString());
      setState(() {
        searchSnapshot = val;
        print(searchSnapshot);
      });
    });
  }
  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
        itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return searchMedicineList(
            searchSnapshot.documents[index].data["name"],
            searchSnapshot.documents[index].data["company"],
            searchSnapshot.documents[index].data["price"],
            searchSnapshot.documents[index].data["discount"],
            searchSnapshot.documents[index].data["description"],
          );
        })
        : Container();
  }
  String searchString;
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) => medicalStore()));
    }
    int selectedIndex=2;
    return WillPopScope(
        onWillPop: _onBackPressed,
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
        title: Text('Digital Health'),
      ),
      body: Container(
          child: Column(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          searchString=value.toLowerCase();
                          initaiteSearch();
                        });
                      },
                      controller: searchTextEditingcontroller,
                      decoration: InputDecoration(
                          hintText: "Search Username/Interests...",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  GestureDetector(
                    // onTap: () {
                    //   initaiteSearch();
                    // },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF8F48F7),
                            // gradient: LinearGradient(colors: [
                            //   const Color(0x36FFFFFF),
                            //   const Color(0x0FFFFFFF)
                            // ]),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(8),
                        child: Image.asset("assets/images/search_white.png")),
                  ),
                ],
              ),
            ),
            Expanded(child: searchList(),)
          ])),
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
    ));
  }
}




class searchMedicineList extends StatefulWidget {
  final String name;
  final String company;
  final int price;
  final int discount;
  final String description;
  searchMedicineList(this.name, this.company,this.price,this.discount,this.description);

  @override
  _searchMedicineListState createState() => _searchMedicineListState();
}

class _searchMedicineListState extends State<searchMedicineList> {
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
                    if(simpleIntInput==0){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => medicineListPage()));
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
                                builder: (context) => medicineListPage()));
                      });
                    }
                  },
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
