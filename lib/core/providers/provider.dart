import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:presentacion/core/model/reporte.dart';
import 'package:presentacion/core/model/validation_item.dart';
import 'package:presentacion/core/services/firestore_services.dart';
import 'package:presentacion/core/utilities/constanst.dart';
import 'package:uuid/uuid.dart';

class ReportProvider with ChangeNotifier{
  final firestoreService = FirestoreService();

  ValidationItem name = ValidationItem(null,null);
  ValidationItem phone = ValidationItem(null,null);
  ValidationItem dni = ValidationItem(null,null);
  ValidationItem placeIncident = ValidationItem(null,null);
  ValidationItem description = ValidationItem(null,null);
  ValidationItem aggressor = ValidationItem(null,null);
  ValidationItem date = ValidationItem(null,null);

  var uuid = Uuid();

  Stream<List<Report>> get reports => firestoreService.getReports();

  ValidationItem get _name => name;
  ValidationItem get _phone => phone;
  ValidationItem get _dni => dni;
  ValidationItem get _placeIncident => placeIncident;
  ValidationItem get _description => description;
  ValidationItem get _aggressor => aggressor;
  ValidationItem get _date => date;


  bool get isValid {
    if (_name.value != null
        && _phone.value != null
        && _dni.value != null
        && _placeIncident.value != null
        && _description.value != null
        && _date.value != null){

      return true;
    } else {
      changeName("");
      changePhone("");
      changeDNI("");
      changePlaceIncident("");
      changeDescription("");
      changeDate("");
      return false;
    }
  }

  void changeName(String val){
    if (val.length >= 1){
      name = ValidationItem(val,null);
    } else {
      name = ValidationItem(null, txtRequired);
    }
    notifyListeners();
  }

  void changePhone(String val){
    if (val.length >= 1){
      phone = ValidationItem(val,null);
    } else {
      phone = ValidationItem(null, txtRequired);
    }
    notifyListeners();
  }

  void changeDNI(String val){
    if (val.length >= 1){
      dni = ValidationItem(val,null);
    } else {
      dni = ValidationItem(null, txtRequired);
    }
    notifyListeners();
  }

  void changePlaceIncident(String val){
    if (val.length >= 1){
      placeIncident = ValidationItem(val,null);
    } else {
      placeIncident = ValidationItem(null, txtRequired);
    }
    notifyListeners();
  }

  void changeDescription(String val){
    if (val.length >= 1){
      description = ValidationItem(val,null);
    } else {
      description = ValidationItem(null, txtRequired);
    }
    notifyListeners();
  }

  void changeAggressor(String val){
    aggressor = ValidationItem(val,null);
    notifyListeners();
  }

  void changeDate(String val){
    print(val);
    print("cambiossss");
    if (val.length >= 1){
      date = ValidationItem(val,null);
    } else {
      date = ValidationItem(null, txtRequired);
    }
    notifyListeners();
  }

  saveReport(){
  print(date.value.toString());
    var create = Report(
        name: name.value.toString() ,
        phone: phone.value.toString(),
        placeIncident: placeIncident.value.toString(),
        description: description.value.toString(),
        aggressor: aggressor.value,
        date: date.value.toString(),
        id: uuid.v1() );
    firestoreService.saveReport(create);
    notifyListeners();
  }


}