import 'package:firebase_auth/firebase_auth.dart';
import 'details.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential).catchError((e) {
      print(e.toString());
    });;

          FirebaseUser user = result.user;

          if(user != null){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeScreen(phone_number: _phoneController.text,name:_nameController.text)
            ));
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Enter the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async{
                      final code = _codeController.text.trim();
                      AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

                      AuthResult result = await _auth.signInWithCredential(credential).catchError((e) {
      print(e.toString());
    });

                      FirebaseUser user = result.user;

                      if(user != null){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => HomeScreen(phone_number: _phoneController.text,name:_nameController.text)
                        ));
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SingleChildScrollView(
        reverse: true,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/illustration-2.png',
                     fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Registration',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Add your name and phone number. we'll send you a verification code so we know you're real",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "name",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: MediaQuery.of(context).size.height/20,
                          ),
                        ),
                        controller: _nameController,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "number",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size:  MediaQuery.of(context).size.height/20,
                          ),
                        ),
                        controller: _phoneController,
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            //_phoneController.text = _phoneController.text;
                          final phone = _phoneController.text.trim();

                          loginUser(phone, context);
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.purple),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Send',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
               Padding(padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),) 
              ],
            ),
           
          ),
        ),
      ),
    );
    // Scaffold(
    //     body: SingleChildScrollView(
    //       child: Container(
    //         padding: EdgeInsets.all(32),
    //         child: Form(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

    //               SizedBox(height: 16,),

    //               TextFormField(
    //                 decoration: InputDecoration(
    //                     enabledBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(8)),
    //                         borderSide: BorderSide(color: Colors.grey[200])
    //                     ),
    //                     focusedBorder: OutlineInputBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(8)),
    //                         borderSide: BorderSide(color: Colors.grey[300])
    //                     ),
    //                     filled: true,
    //                     fillColor: Colors.grey[100],
    //                     hintText: "Mobile Number"

    //                 ),
    //                 controller: _phoneController,
    //               ),

    //               SizedBox(height: 16,),


    //               Container(
    //                 width: double.infinity,
    //                 child: FlatButton(
    //                   child: Text("LOGIN"),
    //                   textColor: Colors.white,
    //                   padding: EdgeInsets.all(16),
    //                   onPressed: () {
    //                     final phone = _phoneController.text.trim();

    //                     loginUser(phone, context);

    //                   },
    //                   color: Colors.blue,
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //     )
    // );
  }
}