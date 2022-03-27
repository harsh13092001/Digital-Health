import 'package:digital_health/view/home.dart';
import 'package:digital_health/view/record.dart';
import 'package:digital_health/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/model/keepLogin.dart';
import 'package:digital_health/model/user.dart';
class HomeScreen extends StatefulWidget {
  final String name;
  final String phone_number;

  HomeScreen({this.name, this.phone_number});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
 
  void insertDetails()async {
    print("done11111111");
    

    if (_docController.text == "patient") {
      print("done111111111111111111111111111111");
     await Firestore.instance
        .collection("user")
        .document(widget.phone_number)
        .setData({
      'age': _ageController.text,
      'gender': _genderController.text,
      'mobile': widget.phone_number,
      'name': widget.name,
      'record_cnt':0
    });
     Helperfunctions.saveFirstTimeAppUseSharedPreference("False");
     
     
      userInfo.userPhoneNumber=widget.phone_number;
      userInfo.user_name=widget.name;
        
        userInfo.gender=_genderController.text;
        
        userInfo.age=_ageController.text;
     Helperfunctions.saveUserNumberSharedPreference(widget.phone_number);
    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => home()
                        )).catchError((e) {
      print(e.toString());
    });
    }
    if (_docController.text == "doctor") {
      print("done111111111111111111111111111111");
     await Firestore.instance
        .collection("doctor")
        .document(widget.phone_number)
        .setData({
      'degree':"general practitioner",
      'gender': _genderController.text,
      'mobile': widget.phone_number,
      'name': widget.name,
      'regNum':"123456789",
      'age': _ageController.text,
      
    });
   await Firestore.instance
        .collection("user")
        .document(widget.phone_number)
        .setData({
      'age': _ageController.text,
      'gender': _genderController.text,
      'mobile': widget.phone_number,
      'name': widget.name,
      'record_cnt':0
    });
    userInfo.userPhoneNumber=widget.phone_number;
    userInfo.isDoctor="Doctor";
    Helperfunctions.saveUserNumberSharedPreference(widget.phone_number);
     Helperfunctions.saveFirstTimeAppUseSharedPreference("False");
    Helperfunctions.saveUserProfessionSharedPreference("Doctor");
      userInfo.userPhoneNumber=widget.phone_number;
      userInfo.user_name=widget.name;
        userInfo.Degree="general practitioner";
        userInfo.gender=_genderController.text;
        userInfo.registrationNum="123456789";
        userInfo.age=_ageController.text;
        
    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => record()
                        )).catchError((e) {
      print(e.toString());
    });
    }
  }

  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _docController = TextEditingController();
   
   bool value = false;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFDB50FF),
      body:
          //reverse: true,

          //padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
           SingleChildScrollView(
             scrollDirection:Axis.vertical,
              //physics: ClampingScrollPhysics(),
             // padding: EdgeInsets.only(bottom: 15),
              
                  child: IntrinsicHeight(
                    child: Column(
                      
        children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[Container(height: 24, width: 24)],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                      child: Stack(
                        children: <Widget>[
                          Text("Welcome!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                              child: Container(
                                  child: Center(
                                child: Text("Add other details here",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                    )),
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                              child: Container(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.name,
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border:
                                        Border.all(width: 1.0, color: Colors.black87)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.phone_number,
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border:
                                        Border.all(width: 1.0, color: Colors.black87)),
                              ),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Gender",
                                      ),
                                      controller: _genderController,
                                      //child: Text("Age", style: TextStyle(color: Colors.white70),)
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border:
                                        Border.all(width: 1.0, color: Colors.black87)),
                              ),
                            ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                          hintText: "Age", fillColor: Colors.white),
                                      controller: _ageController,
                                      //child: Text("Age", style: TextStyle(color: Colors.white70),)
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    border:
                                        Border.all(width: 1.0, color: Colors.black87)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width/7,0, 0, 0),
                              child: 
                              Center(
                                child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ), //SizedBox
                        Text(
                          'Are You a doctor?',
                          style: TextStyle(fontSize: 17.0, color: Colors.grey[700]),
                        ), //Text
                        SizedBox(width: 10), //SizedBox
                        /** Checkbox Widget **/
                        Checkbox(
                          value: this.value,
                          onChanged: (bool value) {
                            setState(() {
                                this.value = value;
                                 if (value) {
                                      _docController.text = "doctor";
                                     
                                    
                                    }
                                    ;
                                    if (value) {
                                      _docController.text = "patient";
                                     
                                    }
                                    ;
                            });
                          },
                        ), //Checkbox
                      ], //<Widget>[]
                    ),
                              )
                              // ToggleSwitch(
                              //   initialLabelIndex: 0,
                              //   minWidth: 150,
                              //   minHeight: 50.0,
                              //   icons: [
                              //     Icons.people,
                              //     Icons.local_hospital,
                              //   ],
                              //   cornerRadius: 20.0,
                              //   totalSwitches: 2,
                              //   iconSize: 30.0,
                              //   fontSize: 18,
                              //   activeBgColors: [[Colors.pinkAccent[100],Colors.lightBlueAccent, Colors.purpleAccent], [Colors.pinkAccent[100],Colors.lightBlueAccent, Colors.purpleAccent]],
                              //   labels: [
                              //     'pateint',
                              //     'Doctor',
                              //   ],
                              //   onToggle: (index) {
                              //     if (index == 0) {
                              //       _docController.text = "pateint";
                              //       print(_docController.text);
                                  
                              //     }
                              //     ;
                              //     if (index == 1) {
                              //       _docController.text = "doctor";
                              //       print(_docController.text);
                              //     }
                              //     ;
                              //   },
                              // ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, MediaQuery.of(context).size.height / 15, 0, MediaQuery.of(context).size.height / 20),
                              child: GestureDetector(
                                onTap: () {
                                  insertDetails();
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height / 15,
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Align(
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                            color: Colors.white70, fontSize: 20),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors : [Colors.blue[700], Colors.lightBlue]),
                                      borderRadius: BorderRadius.circular(12),
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
        ],
      ),
                  ),
                
            ),
          
    );
  }
}
