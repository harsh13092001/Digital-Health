import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/view/home.dart';
import 'package:digital_health/view/medicineList.dart';
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
import 'package:quantity_input/quantity_input.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  deleteCart()async{
    var doc_ref = await Firestore.instance.collection("user").document(userInfo.userPhoneNumber).collection("cart").getDocuments();
    doc_ref.documents.forEach((result) async {
      return await Firestore.instance.collection("user").document(userInfo.userPhoneNumber).collection("cart").document(result.documentID).delete();
    });
  }
  Widget cartList() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection("user").document(userInfo.userPhoneNumber).collection("cart")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ExpandableCartList(
                    snapshot.data.documents[index].data["name"],
                    snapshot.data.documents[index].data["company"],
                    snapshot.data.documents[index].data["price"],
                    snapshot.data.documents[index].data["discount"],
                    snapshot.data.documents[index].data["description"],
                    snapshot.data.documents[index].data["quantity"],
                  );
                });
          } else {
            return Container();
          }
        });
  }

  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) => medicalStore()));
    }
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
            title: Text('My Cart'),
            actions: [
              IconButton(
                  icon: Icon(Icons.shopping_cart), onPressed: (){

              })
            ],
          ),
          body : cartList(),
          bottomNavigationBar: Container(
            height: 65,
            padding: EdgeInsets.only(right: 10,left: 10),
            alignment: Alignment.centerRight,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total - "+userInfo.totalCart.toString()+"\$",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                ElevatedButton(
                  child: Text(
                    'Checkout >',
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
                    deleteCart();
                    userInfo.totalCart=0;
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => medicineListPage()));
                  },
                ),
              ],
            ),
          ),
        )));
  }
}



class ExpandableCartList extends StatefulWidget {
  final String name;
  final String company;
  final int price;
  final int discount;
  final String description;
  final int quantity;
  ExpandableCartList(this.name, this.company,this.price,this.discount,this.description,this.quantity);

  @override
  _ExpandableCartListState createState() => _ExpandableCartListState();
}

class _ExpandableCartListState extends State<ExpandableCartList> {
  int simpleIntInput = 0;
  @override
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  Widget build(BuildContext context) {
    double discountPrice= widget.price - widget.price*(widget.discount/100);
    int originalPrice=discountPrice.toInt();
    return Container(
      color: Colors.grey[350],
      padding: EdgeInsets.fromLTRB(2, 0, 2, 1),
      child: Card(
        child: ExpansionTileCard(
          key: cardA,
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
              Text(
                  'Quantity: '+ widget.quantity.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  )
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
        ),
      ),
    );
  }
}
