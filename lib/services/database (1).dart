import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_health/model/user.dart';

class DatabaseMethods {
  getMedicineSearch(String medicine)async{
    return await Firestore.instance.collection("medicines").where("indexing", arrayContains : medicine).getDocuments();
  }
  getUserRecord(String userName) async {
    Firestore.instance
        .collection("user")
        .where("name", arrayContains: userName)
        .getDocuments();
    var doc_ref = await Firestore.instance.collection("user").where("name", arrayContains: userName).getDocuments();
    doc_ref.documents.forEach((result) async {
      return await Firestore.instance.collection("user").document(result.documentID).collection("record").getDocuments();
    });
  }
  getDoctorInfo(String phoneNumber)async{
    return await Firestore.instance
        .collection("doctor")
        .where("mobile", isEqualTo: phoneNumber)
        .getDocuments();

  }
  getPatientInfo(String phoneNumber)async{
    print("hi");
    return await Firestore.instance
        .collection("user")
        .where("mobile", isEqualTo: phoneNumber)
        .getDocuments();

  }

  void increaserecord_cnt(String phoneNumber) async{

    await Firestore.instance.collection("user").document(phoneNumber).updateData({"record_cnt":FieldValue.increment(1)});


  }


  addUserRecord(String phone , String daigonais,var medicine,List report,String treatment )async {
    int record_cnt;
    print(phone);
    await Firestore.instance.collection("user").where(
        "mobile", isEqualTo: phone).getDocuments().then((value) {
      record_cnt = value.documents[0].data["record_cnt"];
    });
    ;
    Stream doc = await Firestore.instance
        .collection("user").document(phone).collection("record").snapshots();

    await Firestore.instance
        .collection("user").document(phone).collection("record").document(
        record_cnt.toString()).setData({
      "age": 25,
      "daignosis": daigonais,
      " date": FieldValue.serverTimestamp(),
      "degree": userInfo.Degree,
      "doctorName": userInfo.user_name,
      "medicine": medicine,
      "registrationNum": userInfo.registrationNum,
      "report": report,
      "treatment": treatment,
      "recordcount": record_cnt + 1,

    }).catchError((e) {
      print(e.toString());
    });
    await increaserecord_cnt(phone);
  }
}