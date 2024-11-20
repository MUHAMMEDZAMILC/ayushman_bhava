import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ayushman_bhava/utils/globalvariable.dart';
import 'package:ayushman_bhava/utils/helper/help_toast.dart';

import '../../../model/logindatamodel.dart';
import '../../../model/patientlistmodel.dart';
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
}
