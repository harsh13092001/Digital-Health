import 'package:digital_health/model/user.dart';
import 'package:digital_health/services/database.dart';
import 'package:digital_health/view/home.dart';
import 'package:flutter/material.dart';
import 'view/signup.dart';
import 'package:digital_health/model/keepLogin.dart';
import "package:digital_health/services/database.dart";
import 'package:digital_health/view/certificate.dart';
//import 'package:digital_health/model/keepLogin.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
String firstTimeAppUser= "True";
DatabaseMethods databaseMethods = new DatabaseMethods();
void getLoggedInState() async {
    await Helperfunctions.getFirstTimeAppUseSharedPreference().then((value) {
      print("bbb");
      print(value);
      if (value!="False") {
        
        setState(() {
          firstTimeAppUser = 'True';

        
        });
      } else {
        setState(() {
          firstTimeAppUser = 'false';

        
        });
        
        
        
   
    
  }
    }
    );
    
    await Helperfunctions.getUserProfSharedPreference().then((value){
      userInfo.isDoctor=value;
    });
    await Helperfunctions.getUserNumberSharedPreference().then((value){
      userInfo.userPhoneNumber=value;
    });
    if(userInfo.isDoctor=="Doctor"){
      databaseMethods.getDoctorInfo(userInfo.userPhoneNumber).then((value){
        userInfo.user_name=value.documents[0].data["name"];
        userInfo.Degree=value.documents[0].data["degree"];
        userInfo.gender=value.documents[0].data["gender"];
        userInfo.registrationNum=value.documents[0].data["regNum"];
        userInfo.age=value.documents[0].data["age"];
        
      });
    }
    else{
      print("yes pateine");
      print(userInfo.userPhoneNumber);
      databaseMethods.getPatientInfo(userInfo.userPhoneNumber).then((value){
        userInfo.user_name=value.documents[0].data["name"];
        //userInfo.Degree=value.documents[0].data["degree"];
        userInfo.gender=value.documents[0].data["gender"];
        print(value.documents[0].data["gender"]);
        userInfo.age=value.documents[0].data["age"];
      });
      print(userInfo.user_name);
     
      print(userInfo.age);
    }
   }
  void initState() {
    getLoggedInState();
    
    super.initState();}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:firstTimeAppUser == 'True'?
      LoginScreen():home()
      ,
    );
  }
}


