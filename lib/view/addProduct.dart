import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/view/home.dart';
import 'package:digital_health/view/medicalStore.dart';
import 'package:digital_health/view/record.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_theme.dart';
import 'package:flutter/material.dart';

class addProduct extends StatefulWidget {
  @override
  _addProductState createState() => _addProductState();
}
enum SingingCharacter { Medicine, Report }
class _addProductState extends State<addProduct> {
  @override
  final descriptionController = TextEditingController();
  final discountController = TextEditingController();
  final companyController = TextEditingController();
  final medicineController = TextEditingController();

  final priceController = TextEditingController();
  SingingCharacter _character = SingingCharacter.Medicine;
  bool isMedicine=true;
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) => medicalStore()));
    }
    int selectedIndex = 2;
    return WillPopScope(
        onWillPop: _onBackPressed,
        child:SafeArea(child: Scaffold(
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
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Medicine / Report & Test Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Medicine Name"),
                    controller: medicineController,
                  ),
                  Text("Description",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Description"),
                    controller: descriptionController,
                  ),
                  Text("Company Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Company Name"),
                    controller: companyController,
                  ),
                  Text("Price of Product",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Price of Product"),
                    controller: priceController,
                  ),
                  Text("Discount",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Discount Percentage"),
                    controller: discountController,
                  ),
                  ListTile(
                    title: const Text('Medicine'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.Medicine,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                          isMedicine=true;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Report & Tests'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.Report,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value;
                          isMedicine=false;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text(
                      'Add Product',
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
                      Map<String,dynamic>productMap= new Map<String, dynamic>();
                      List<String> indexing=[];
                      String temp="";
                      for(int i=0;i<medicineController.text.length;i++){
                        indexing.add(temp);
                        temp+=medicineController.text[i].toLowerCase();
                      }
                      indexing.add(temp);
                      productMap={
                        "company": companyController.text,
                        "name":medicineController.text,
                        "discount":int.parse(discountController.text),
                        "price":int.parse(priceController.text),
                        "isMedicine": isMedicine,
                        "description":descriptionController.text,
                        "indexing":indexing,
                      };
                      Firestore.instance.collection("medicines").add(productMap);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => medicalStore()));
                    },
                  ),
                ],
              ),
            ),
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
