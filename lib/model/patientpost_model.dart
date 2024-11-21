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
    String? totalAmount;
    String? discountAmount;
    String? advanceAmount;
    String? balanceAmount;
    String? dateNdTime;
    String? id;
    String? male;
    String? female;
    Branch? branch;
    String? treatments;

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
        "branch": branch?.id.toString(),
        "treatments": treatments,
    };
    final map = <String, dynamic>{};
    tomap() {
       map["name"]= name;
        map["excecutive"]= excecutive;
        map["payment"]= payment;
        map["phone"]= phone;
        map["address"]= address;
        map["total_amount"]= totalAmount;
        map["discount_amount"]= discountAmount;
        map["advance_amount"]= advanceAmount;
        map["balance_amount"]= balanceAmount;
        map["date_nd_time"]= dateNdTime;
        map["id"]= id;
        map["male"]= male;
        map["female"]= female;
        map["branch"]= branch?.id.toString();
        map["treatments"]= treatments;
        return map;
    }
}
