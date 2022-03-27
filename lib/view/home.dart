import 'package:digital_health/model/user.dart';
import 'package:digital_health/model/keepLogin.dart';
import 'package:digital_health/view/generate.dart';
import 'package:digital_health/view/record.dart';
import 'package:digital_health/view/scan.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:digital_health/view/medicalStore.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
    void initState() {
      getUserData();
      // TODO: implement initState
      //userInfo.userPhoneNumber="+919904407310";
    }
    void getUserData()async{
      await Helperfunctions.getUserNumberSharedPreference()
      .then((value) {
      userInfo.userPhoneNumber=value;
  
    });
    }
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
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
          body:ListView(
            children: <Widget>[
              userInfo.isDoctor == "Doctor"?
              Card(
                child: ListTile(
                  title: Text("Scan Code"),
                  leading: Icon(Icons.qr_code_scanner),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => scanPage()));
                  },
                ),
              ):Container(),
              Card(
                child: ListTile(
                  title: Text("Generate QR Code"),
                  leading: Icon(Icons.edit),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => generatePage()));
                  },
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
                    MaterialPageRoute(builder: (context) => record(phone: userInfo.userPhoneNumber)));
              }
              else if(index==1){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => home()));
                }
              else if(index==2){
                Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => medicalStore()));
          
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
                 iconData: Icons.medical_services_outlined,
            label: 'Medical Store',
              ),
            ],
          ),
      )
    );
  }
}
