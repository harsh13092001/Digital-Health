import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/model/user.dart';
import 'package:digital_health/view/home.dart';
import 'package:digital_health/view/record.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:digital_health/view/record.dart';
import 'package:digital_health/services/database.dart';
class scanPage extends StatefulWidget {
  @override
  _scanPageState createState() => _scanPageState();
}

class _scanPageState extends State<scanPage> {
  bool backCamera = false;
  String barcode = "";
  void Nav(){

    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => record(phone: barcode)
                        ));
  }
  Future scanCode() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode,
      
      
      );
      
     Navigator.push(context, MaterialPageRoute(
                            builder: (context) => record(phone: barcode)
                        ));
    } catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    print("Idont know why");
    
    int selectedIndex = 1;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFDB50FF),
              title: Text("Digital Health"),
              // actions: <Widget>[
              //   IconButton(
              //     icon: Icon(Icons.qr_code_scanner_rounded),
              //     onPressed: () async {
              //       ScanResult codeSanner = await BarcodeScanner.scan(
              //         options: ScanOptions(
              //           useCamera: -1,
              //         ),
              //       ); //barcode scnner
              //       setState(() {
              //         qrCodeResult = codeSanner.rawContent;
              //       });
              //     },
              //   )
              // ],
            ),
            body: Container(
              child: Text(barcode),
            ),
            // Center(
            //   child: Text(
            //     (qrCodeResult == null)||(qrCodeResult == "")
            //         ? "Please Scan to show some result"
            //         : "Result:" + qrCodeResult,
            //     style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
            //   ),
            // ),
            floatingActionButton: FloatingActionButton(
          onPressed: scanCode,
          tooltip: 'Scan',
          child: Icon(Icons.scanner),
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

int camera = 1;