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
  final String userId;


  Report({ required this.name, required this.phone, required this.placeIncident,
    required this.description,this.aggressor, required this.id , required this.date, required this.userId});

  factory Report.fromJson( Map<String, dynamic> json ){

    return Report(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        placeIncident: json['placeIncident'],
        description: json['description'],
        aggressor: json['aggressor'],
        date: json['date'],
        userId: json['userId']
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
      'date' : date,
      // 'images' : images,
      'userId': userId,
      'status': 1,
      'statusName' : "En espera"
    };
  }
}

