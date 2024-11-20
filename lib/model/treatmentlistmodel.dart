// To parse this JSON data, do
//
//     final treatmentList = treatmentListFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'patientlistmodel.dart';

TreatmentList treatmentListFromJson(String str) => TreatmentList.fromJson(json.decode(str));

String treatmentListToJson(TreatmentList data) => json.encode(data.toJson());

class TreatmentList {
    bool? status;
    String? message;
    List<Treatment>? treatments;

    TreatmentList({
        this.status,
        this.message,
        this.treatments,
    });

    factory TreatmentList.fromJson(Map<String, dynamic> json) => TreatmentList(
        status: json["status"],
        message: json["message"],
        treatments: json["treatments"] == null ? [] : List<Treatment>.from(json["treatments"]!.map((x) => Treatment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "treatments": treatments == null ? [] : List<dynamic>.from(treatments!.map((x) => x.toJson())),
    };
}

class Treatment {
    int? id;
    List<Branch>? branches;
    String? name;
    String? duration;
    String? price;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? male;
    int? female;

    Treatment({
        this.id,
        this.branches,
        this.name,
        this.duration,
        this.price,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.male=0,
        this.female=0,
    });

    factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        id: json["id"],
        branches: json["branches"] == null ? [] : List<Branch>.from(json["branches"]!.map((x) => Branch.fromJson(x))),
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
        isActive: json["is_active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
        "name": name,
        "duration": duration,
        "price": price,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}


