// To parse this JSON data, do
//
//     final branchList = branchListFromJson(jsonString);

import 'dart:convert';

import 'patientlistmodel.dart';

BranchList branchListFromJson(String str) => BranchList.fromJson(json.decode(str));

String branchListToJson(BranchList data) => json.encode(data.toJson());

class BranchList {
    bool? status;
    String? message;
    List<Branch>? branches;

    BranchList({
        this.status,
        this.message,
        this.branches,
    });

    factory BranchList.fromJson(Map<String, dynamic> json) => BranchList(
        status: json["status"],
        message: json["message"],
        branches: json["branches"] == null ? [] : List<Branch>.from(json["branches"]!.map((x) => Branch.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "branches": branches == null ? [] : List<dynamic>.from(branches!.map((x) => x.toJson())),
    };
}


