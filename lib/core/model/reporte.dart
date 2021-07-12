import 'package:presentacion/core/model/ReportImages.dart';
import 'package:flutter/material.dart';

class Report{
  final String id;
  final String name;
  final String phone;
  final String placeIncident;
  final String description;
  final String? aggressor;
  final String date;

  Report({ required this.name, required this.phone, required this.placeIncident,
    required this.description,this.aggressor, required this.id , required this.date});

  factory Report.fromJson( Map<String, dynamic> json ){
    print(json['id'] + "Reportttt");
    return Report(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        placeIncident: json['placeIncident'],
        description: json['description'],
        aggressor: json['aggressor'],
        date: json['date']
    );
  }


  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'name':name,
      'phone':phone,
      'placeIncident' : placeIncident,
      'description': description,
      'aggressor' : aggressor,
      'date' : date
    };
  }
}

