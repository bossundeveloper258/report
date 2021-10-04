import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presentacion/core/model/reporte.dart';

class FirestoreService{
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get Report
  Stream<List<Report>> getReports(){
    print(FirebaseAuth.instance.currentUser!.uid);
    return _db
        //.collection('Users')
        //.doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Reports')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Report.fromJson(doc.data()))
        .toList());
  }

  Future<void> saveReport(Report report){
    var options = SetOptions(merge:true);

    return _db
        //.collection('Users')
        //.doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Reports')
        .doc(report.id)
        .set(report.toMap(),options);
  }

  Future<void> removeReport(String reportId){
    return _db
        //.collection('Users')
        //.doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Reports')
        .doc(reportId)
        .delete();
  }
}