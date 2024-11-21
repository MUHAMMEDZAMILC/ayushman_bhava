import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ayushman_bhava/utils/globalvariable.dart';
import 'package:ayushman_bhava/utils/helper/help_toast.dart';

import '../../../model/branchlistmodel.dart';
import '../../../model/logindatamodel.dart';
import '../../../model/patientlistmodel.dart';
import '../../../model/patientpost_model.dart';
import '../../../model/treatmentlistmodel.dart';
import '../../api/urls.dart';
import 'package:http/http.dart' as http;

class ProviderApiService {
  // login api service
  loginuser(context, LoginPost body) async {
    var url = '$baseUrl$loginUrl';
    log(url);
    // log(body.toString());
    final map = <String, dynamic>{};
    map['username'] = body.username;
    map['password'] = body.password;
    try {
      final Uri uri = Uri.parse('$baseUrl$loginUrl');
      var response = await http.post(
        uri,
        body: map,
      );
      log(response.body);
      if (response.statusCode == 200) {
        return loginDataFromJson(response.body);
      }else{
        snackBar(context, message: 'Login Failed');
      }
    } on SocketException {
      snackBar(context, message: 'NetWork Down');
    } catch (e) {
      snackBar(context, message: 'Login Failed');
    }
  }

  // getpatientlist api service
  getpatientlist(context) async{
    List<Patient> empty=[];
    var url = '$baseUrl$patientListUrl';
    log(url);
    try {
    final response =
        await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $logintoken',
    });
    log(response.body);
    if (response.statusCode == 200) {
      return PatientList.fromJson(json.decode(response.body)).patient;
    } else {
      return empty;
    }
    } on SocketException {
      snackBar(context, message: 'NetWork Down');
      return empty;
    } catch (e) {
      snackBar(context, message: 'Login Failed');
      return empty;
    }
  }
  // getpatientlist api service
  getbranchlist(context) async{
    List<Branch> empty=[];
    var url = '$baseUrl$branchListUrl';
    log(url);
    try {
    final response =
        await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $logintoken',
    });
    log(response.body);
    if (response.statusCode == 200) {
      return BranchList.fromJson(json.decode(response.body)).branches;
    } else {
      return empty;
    }
    } on SocketException {
      snackBar(context, message: 'NetWork Down');
      return empty;
    } catch (e) {
      snackBar(context, message: 'Login Failed');
      return empty;
    }
  }
  // getpatientlist api service
  gettreatmentlist(context) async{
    List<Treatment> empty=[];
    var url = '$baseUrl$treatmentListUrl';
    log(url);
    try {
    final response =
        await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $logintoken',
    });
    log(response.body);
    if (response.statusCode == 200) {
      return TreatmentList.fromJson(json.decode(response.body)).treatments;
    } else {
      return empty;
    }
    } on SocketException {
      snackBar(context, message: 'NetWork Down');
      return empty;
    } catch (e) {
      snackBar(context, message: 'Login Failed');
      return empty;
    }
  }

  // register patient api service
  patientcreation(context,PatientPost body) async{
     var url = '$baseUrl$patientUpdateUrl';
    log(url);
    dynamic bodyenc = jsonEncode(body.toJson());
    log(bodyenc);
    try {
        final Uri uri = Uri.parse(url);

    var response = await http.post(uri, headers:  {
      'Authorization': 'Bearer $logintoken',
      'Content-Type': 'application/json', 'Accept': '*/*'
    },body: bodyenc);
    log(response.body);
    if (response.statusCode == 200) {
        log("me s s a g e");
        return {"Result":true};
      
    } else {
      snackBar(context, message: "Registration Failed");
      return {"Result":false};
    }
    } on SocketException {
      snackBar(context, message: 'NetWork Down');
       return {"Result":false};
    } catch (e) {
      snackBar(context, message:"Registration Failed");
      return {"Result":false};
    }
   
  }
}
