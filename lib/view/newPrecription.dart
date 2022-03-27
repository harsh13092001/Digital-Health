import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/model/user.dart';
import 'package:digital_health/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_health/view/generate.dart';
import 'package:digital_health/view/scan.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/widgets.dart';

class newPrecription extends StatefulWidget {
  @override
  _newPrecriptionState createState() => _newPrecriptionState();
}

class _newPrecriptionState extends State<newPrecription> {
  final diagnosisController = TextEditingController();
  @override
  Widget recordList() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection("user")
            .document("qIiWmn3qQLa4NfYR1z9X")
            .collection("record")
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ExpandableList(
                  snapshot.data.documents[index].data["medicine"].length,
                  snapshot.data.documents[index].data["doctorName"],
                  snapshot.data.documents[index].data["degree"],
                  snapshot.data.documents[index].data["registrationNum"],
                  snapshot.data.documents[index].data["daignosis"],
                  snapshot.data.documents[index].data["treatment"],
                  snapshot.data.documents[index].data["medicine"],
                  snapshot.data.documents[index].data["report"],
                  // "qIiWmn3qQLa4NfYR1z9X",
                  // "4NldzB7DHrTClf9JCPNv",
                  // snapshot.data.documents[index].data["chatroomId"].toString().replaceAll("_", "").replaceAll(Info.user_email, ""),
                  // snapshot.data.documents[index].data["chatroomId"],
                  // snapshot.data.documents[index].data["name"].toString().replaceAll("_", "").replaceAll(Info.user_Name, ""),
                  // snapshot.data.documents[index].data["name"].toString().replaceAll("_", "").replaceAll(Info.user_Name, ""),
                );
              })
              : Container();
        });
  }
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = 0;
  Widget build(BuildContext context) {
    return SafeArea(
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
          body: Column(
            children: [
              recordList(),
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[300])
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Mobile Number"

                    ),
                    controller: diagnosisController,
                  ),
                ],
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
              if (index == 0) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => newPrecription()));
              } else if (index == 1) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => home()));
              } else if (index == 2) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => home()));
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
                label: 'Records',
              ),
              FFNavigationBarItem(
                iconData: Icons.qr_code,
                label: 'QR Code',
              ),
              FFNavigationBarItem(
                iconData: Icons.settings,
                label: 'Settings',
              ),
            ],
          ),
        ));
  }
}

class ExpandableList extends StatelessWidget {
  final int medicineNum;
  final String doctorName;
  final String registrationNum;
  final String degree;
  final String daignosis;
  final String treatment;
  final List medicine;
  final List report;
  ExpandableList(this.medicineNum, this.doctorName, this.degree,
      this.registrationNum, this.daignosis, this.treatment, this.medicine,this.report);
  @override
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Card(
      child: ExpansionTileCard(
        key: cardA,
        leading: CircleAvatar(child: Icon(Icons.medical_services),backgroundColor: Colors.white,),
        title: Text(doctorName, style: TextStyle(color: Colors.black),),
        // subtitle: Text('I expand'),
        children: <Widget>[
          Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          Container(
            color: Colors.purpleAccent,
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.settings_overscan_rounded),
                Column(
                  children: [
                    Text(doctorName),
                    Text(degree),
                    Text(registrationNum)
                  ],
                )
              ],
            ),
          ),
          daignosis.length != 0
              ? Row(
            children: [
              Text(" Daignosis: "),
              Text(daignosis),
            ],
          )
              : Container(),
          treatment.length != 0
              ? Row(
            children: [
              Text(" Treatment: "),
              Text(treatment),
            ],
          )
              : Container(),
          Container(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              radius: 20,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/rx.jpg"),
                      fit: BoxFit.fill),
                  color: Colors.black,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: medicine.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("• "),
                        Text(medicine[index]['name'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Text(medicine[index]['instruction']),
                  ],
                ),
              );
            },
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
          ),
          report.length!=0 ?Container(
              alignment: Alignment.centerLeft,
              child: Text(" Reports",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)):Container(),
          report.length!=0 ?ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: report.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("- "),
                        Text(report[index],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ],
                ),
              );
            },
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
          ):Container(),
          Divider(),
        ],
      ),
    );
  }
}
