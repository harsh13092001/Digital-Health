import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/model/user.dart';
import 'package:digital_health/view/record.dart';

// class Medicine{
//   String name;
//   bool day;
//   bool afternoon;
//   bool evening;
//   bool night;
//   bool beforeLunch;
//   bool beforeDinner;
//
//   Medicine({this.name, this.day,this.afternoon,this.beforeDinner,this.beforeLunch,this.evening,this.night});
// }

makeMedicineList(String userPhoneNumber) async {
  List record = [];
  List recordDisease = [];
  var doc = await Firestore.instance.collection('user').document(userPhoneNumber).collection("record").getDocuments();
  doc.documents.forEach((result) {
    List<List<dynamic>> medicines = [];
    List<List<dynamic>> listMedicine = [];
    Firestore.instance.collection("user").document(userPhoneNumber).collection("record").document(result.documentID).collection('medicine').getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result2) async {
        List<dynamic> medicine1 = [
          result2.data["name"],
          result2.data["afternoon"],
          result2.data["day"],
          result2.data["evening"],
          result2.data["night"],
          result2.data["beforeDinner"],
          result2.data["beforeLunch"]
        ];
        listMedicine.add(medicine1);
      });
    });
    record.add(listMedicine);
    recordDisease.add(result.data["disease"]);
  });
  userInfo.recordDisease = recordDisease;
  userInfo.record = record;
}
