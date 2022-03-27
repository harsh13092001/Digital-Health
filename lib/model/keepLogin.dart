import 'package:shared_preferences/shared_preferences.dart';


class Helperfunctions{
  static String sharedPreferenceUserProfession = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceProfKey = "USERNAMEKEY";
  static String sharedPreferenceUserNumberKey = "USERENUMBERKEY";
 static String  sharedPerferenceUserListKey = "null";
 static String sharedPreferenceUserOkkey = "ListNotSet";
  static String firstTimeApp = 'True' ;

   static Future<void> saveFirstTimeAppUseSharedPreference(String firstTimeUserApp) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(firstTimeApp, firstTimeUserApp);
  }
   static Future<void> saveUserProfeesion(bool isUserDoctor) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserProfession, isUserDoctor);
  }
  // saving data to SharedPreference
 
 static Future<void> saveUserProfessionSharedPreference(String userProf) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceProfKey, userProf);
  }
  static Future<void> saveUserNameSharedPreference(String userName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }
  
  static Future<void> saveUserNumberSharedPreference(String userNumber) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNumberKey, userNumber);
  }
 
// getting data to SharedPreference
static Future<String> getUserOkkeySharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return   prefs.getString(sharedPreferenceUserOkkey);
  }
static Future<String> getUserProfSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return   prefs.getString(sharedPreferenceProfKey);
  }

  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserNameKey);
  }
  static Future<String> getUserNumberSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserNumberKey);
  }
  
  static Future<String>getFirstTimeAppUseSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(firstTimeApp);
  }
  static Future<bool> getUserProfession() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserProfession);
  }
   
}