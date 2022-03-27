import 'dart:ui';
import 'package:digital_health/view/medicalStore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/model/user.dart';
import 'package:digital_health/view/home.dart';
//import 'package:digital_health/view/newPrecription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digital_health/services/database.dart';
import 'package:digital_health/view/generate.dart';
import 'package:digital_health/view/scan.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter/widgets.dart';

class record extends StatefulWidget {
  @override
  final String phone ;
  record({this.phone});
  _recordState createState() => _recordState();
}

class _recordState extends State<record> {
  final diagnosisController = TextEditingController();
  @override
  bool addPrecription = false;
  Widget recordList() {
    print("12"+widget.phone);
    return StreamBuilder(
        stream: Firestore.instance
            .collection("user")
            .document(widget.phone)
            .collection("record")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
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
                  );
                });
          } else {
            return Container();
          }
        });
  }
  Future<bool> _onBackPressed() {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(
        builder: (context) => home()));
  }

  final _formKey = GlobalKey<FormState>();
  int selectedIndex = 0;
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
        child: Scaffold(
      floatingActionButton: new FloatingActionButton(
          elevation: 0.0,
          child: new Icon(Icons.library_add),
          backgroundColor: Color(0xFFFF00FB),
          onPressed: () {
            setState(() {
              addPrecription = !addPrecription;
            });
          }),
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red[500],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.pink, Colors.blue, Colors.purple]),
                      // border: Border.all(color: Colors.blueAccent)
                    ),
                    child: Icon(Icons.emoji_people_outlined, size: 50,color: Colors.white,)),
                Column(
                  children: [
                      Text(userInfo.user_name),
                     Text(userInfo.gender),
                    Text(userInfo.age)
                  ],
                )
              ],
            ),
          ),
          Divider(color: Colors.black,thickness: 3,),
          Text("Health Card"),
          Divider(color: Colors.black,thickness: 3,),
          addPrecription
              ? Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      color: Colors.grey[350],
                      padding: EdgeInsets.only(left: 2,right: 2,bottom: 5,top: 5),
                      child: Column(
                        children: [
                          recordList(),
                          ExpandablePrecription(phone: widget.phone,),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      color: Colors.grey[350],
                      padding: EdgeInsets.only(left: 2,right: 2,bottom: 5,top: 5),
                      child: Column(
                        children: [
                          recordList(),
                        ],
                      ),
                    ),
                  ),
                )
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
                context, MaterialPageRoute(builder: (context) => record(phone: widget.phone)));
          } else if (index == 1) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => home()));
          } else if (index == 2) {
            Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => medicalStore()));;
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
           onData: Icons.medical_services_outlined,
            label: 'Medica icl Store',
          ),
        ],
      ),
    )));
  }
}

class ExpandablePrecription extends StatefulWidget {
  @override
   final String phone;
   ExpandablePrecription({this.phone});
  _ExpandablePrecriptionState createState() => _ExpandablePrecriptionState();
}

class _ExpandablePrecriptionState extends State<ExpandablePrecription> {
  @override
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  
  final treatmentController = TextEditingController();
  final instructionController = TextEditingController();
  final reportController = TextEditingController();
  final medicineController = TextEditingController();
  DatabaseMethods databaseMethods =  new DatabaseMethods();
  final diagnosisController = TextEditingController();

  String daignosis = "";

  List report = [];

  int medicinelen = 1;

  List medicine = [];

  List instruction = [];
  var med_inst=<Map>[];

  Widget build(BuildContext context) {
    daignosis = diagnosisController.text;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Padding(
      padding: EdgeInsets.only(left: 1, right: 1),
      child: Card(
        child: ExpansionTileCard(
          initiallyExpanded: true,
          key: cardA,
          leading: CircleAvatar(
            child: Icon(Icons.medical_services),
            backgroundColor: Colors.white,
          ),
          title: Text(
            treatmentController.text,
            style: TextStyle(color: Colors.black),
          ),
          // subtitle: Text('I expand'),
          children: <Widget>[
            Container(
              color: Colors.purpleAccent,
              height: 10,
            ),
            Container(
                padding: EdgeInsets.only(left: 2,),
                alignment: Alignment.centerLeft,
                child: Text(
                  "New Prescription",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 2,),
              alignment: Alignment.centerLeft,
              child: Text(
                "Daignosis",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Daignosis"),
              controller: diagnosisController,
            ),
            Container(
              padding: EdgeInsets.only(left: 2,),
              alignment: Alignment.centerLeft,
              child: Text(
                "Treatment",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Treatment"),
              controller: treatmentController,
            ),
            Container(
              padding: EdgeInsets.only(left: 2,),
              alignment: Alignment.centerLeft,
              child: Text(
                "Medicine",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            medicine.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: medicine.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("• "),
                                Text(
                                  medicine[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(instruction[index]),
                          ],
                        ),
                      );
                    },
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                  )
                : Container(),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: "Medicine"),
                        controller: medicineController,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 2,),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Instruction',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Instruction"),
                        controller: instructionController,
                      ),
                      ElevatedButton(
                        child: Text(
                          'Add Medicine',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.purpleAccent))),
                        ),
                        onPressed: () {
                          setState(() {
                            medicine.add(medicineController.text);
                            instruction.add(instructionController.text);
                            medicineController.clear();
                            instructionController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
            ),
            Container(
              padding: EdgeInsets.only(left: 2,),
              alignment: Alignment.centerLeft,
              child: Text(
                "Report",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            report.length != 0
                ? ListView.builder(
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
                                Text("• "),
                                Text(
                                  report[index],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                  )
                : Container(),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: "Report / Test"),
                        controller: reportController,
                      ),
                      ElevatedButton(
                        child: Text(
                          'Add Report',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Colors.purpleAccent))),
                        ),
                        onPressed: () {
                          setState(() {
                            report.add(reportController.text);
                            reportController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
            ),
            ElevatedButton(
             
              child: Text(
                'Add Prescription',
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
                 
                databaseMethods.addUserRecord(widget.phone,diagnosisController.text, med_inst,report,treatmentController.text);
               Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => record(phone: widget.phone)));
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
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
  ExpandableList(
      this.medicineNum,
      this.doctorName,
      this.degree,
      this.registrationNum,
      this.daignosis,
      this.treatment,
      this.medicine,
      this.report);
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
        leading: CircleAvatar(
          child: Icon(Icons.medical_services),
          backgroundColor: Colors.white,
        ),
        title: Text(
          doctorName,
          style: TextStyle(color: Colors.black),
        ),
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
                padding: EdgeInsets.only(left:7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Medicine",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text("• "),
                        Text(
                          medicine[index]['name'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
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
          report.length != 0
              ? Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      " Reports",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
              )
              : Container(),
          report.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: report.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 11),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("- "),
                              Text(
                                report[index],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  padding: EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                )
              : Container(),
          Divider(),
        ],
      ),
    );
  }
}
