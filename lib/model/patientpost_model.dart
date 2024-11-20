// To parse this JSON data, do
//
//     final patientPost = patientPostFromJson(jsonString);

import 'dart:convert';

import 'package:ayushman_bhava/model/patientlistmodel.dart';

PatientPost patientPostFromJson(String str) => PatientPost.fromJson(json.decode(str));

String patientPostToJson(PatientPost data) => json.encode(data.toJson());

class PatientPost {
    String? name;
    String? excecutive;
    String? payment;
    String? phone;
    String? address;
    double? totalAmount;
    double? discountAmount;
    double? advanceAmount;
    double? balanceAmount;
    String? dateNdTime;
    String? id;
    List<int>? male=[];
    List<int>? female=[];
    Branch? branch;
    List<int>? treatments=[];

    PatientPost({
        this.name,
        this.excecutive,
        this.payment,
        this.phone,
        this.address,
        this.totalAmount,
        this.discountAmount,
        this.advanceAmount,
        this.balanceAmount,
        this.dateNdTime,
        this.id,
        this.male,
        this.female,
        this.branch,
        this.treatments,
    });

    factory PatientPost.fromJson(Map<String, dynamic> json) => PatientPost(
        name: json["name"],
        excecutive: json["excecutive"],
        payment: json["payment"],
        phone: json["phone"],
        address: json["address"],
        totalAmount: json["total_amount"]?.toDouble(),
        discountAmount: json["discount_amount"]?.toDouble(),
        advanceAmount: json["advance_amount"]?.toDouble(),
        balanceAmount: json["balance_amount"]?.toDouble(),
        dateNdTime: json["date_nd_time"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "excecutive": excecutive,
        "payment": payment,
        "phone": phone,
        "address": address,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "advance_amount": advanceAmount,
        "balance_amount": balanceAmount,
        "date_nd_time": dateNdTime,
        "id": id,
        "male": male,
        "female": female,
        "branch": branch,
        "treatments": treatments,
    };
}
