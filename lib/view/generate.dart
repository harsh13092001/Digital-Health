import 'package:digital_health/model/user.dart';
import 'package:digital_health/view/home.dart';
import 'package:digital_health/view/record.dart';
import 'package:digital_health/widget.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';


class generatePage extends StatefulWidget {
  @override
  _generatePageState createState() => _generatePageState();
}

class _generatePageState extends State<generatePage> {
  @override
    void initState() {
       dummyData = userInfo.userPhoneNumber;
      // TODO: implement initState
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFDB50FF),
            title: Text('Digital Health'),
          ),
          body:ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("please scan the qr code",style: TextStyle(
     color:  Colors.purple,
     fontWeight: FontWeight.w700,
     fontFamily:'RobotoMono',
     fontSize: 30
   ),)),
                // child: Card(
                //   elevation: 5,
                //   child: ListTile(
                //     leading: Icon(Icons.edit),
                //     trailing: FlatButton(
                //       child: Text(
                //         "ENTER",
                //         style: TextStyle(
                //           color: Colors.white,
                //         ),
                //       ),
                //       color: Colors.green,
                //       onPressed: () {
                //         setState(() {
                         
                //         });
                //       },
                //     ),
                //     title: TextField(
                //       controller: qrTextController,
                //       decoration: InputDecoration(
                //         hintText: "please enter some data",
                //       ),
                //     ),
                //   ),
                // ),
              ),
              (dummyData == null)
                  ? Center(child: Text("enter some text to display qr code..."))
                  : Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Container(
                width: 300,
                height: 340,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red[500],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.pink, Colors.blue, Colors.purple]),
                      // border: Border.all(color: Colors.blueAccent)
                ),
                      child: Container(
                        width: 300,
                        height: 310,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red[500],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color:  Colors.white,
                          ),
                        child: QrImage(
                embeddedImage: NetworkImage(
                        "https://avatars1.githubusercontent.com/u/41328571?s=280&v=4",
                ),
                data: dummyData,
                gapless: true,
              ),
                      ),
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
                    MaterialPageRoute(builder: (context) => home()));
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
        )
    );
  }
}

String dummyData=null;

TextEditingController qrTextController = TextEditingController();