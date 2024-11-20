import 'package:ayushman_bhava/controller/service/provider/providerservice.dart';
import 'package:ayushman_bhava/model/logindatamodel.dart';
import 'package:ayushman_bhava/utils/colors.dart';
import 'package:ayushman_bhava/utils/globalvariable.dart';
import 'package:ayushman_bhava/utils/helper/pagenavigator.dart';
import 'package:ayushman_bhava/view/ui/home/homepage.dart';
import 'package:flutter/material.dart';

import '../../../model/patientlistmodel.dart';
import '../../../utils/helper/help_toast.dart';
import '../../../utils/string.dart';
import '../../shared_pref.dart';

class ProviderOperation extends ChangeNotifier {
  ProviderApiService ntop = ProviderApiService();
  bool isbtnloading = false, ispageloading = false;

  // login user provider method
  LoginData? logindata;
  loginuserfn(context, LoginPost body) async {
    isbtnloading = true;
    notifyListeners();
    try {
      logindata = await ntop.loginuser(context, body);
      if (logindata?.status == true) {
        snackBar(context,
            message: logindata?.message ?? '', kcolor: ColorResources.GREEN);
        await SharedPref.save(key: logintokenkey, value: logindata?.token);
        // await SharedPref.save(key:useridkey , value: logindata?.userDetails?.id);
        logintoken = logindata?.token;
        userId = logindata?.userDetails?.id;
        Screen.openAsNewPage(context, const HomeScreen());
      } else {
        snackBar(context, message: logindata?.message ?? '');
      }
    } catch (e) {
      isbtnloading = false;
    }

    isbtnloading = false;
    notifyListeners();
  }

  //  get patients list method
  List<Patient> patient = [];
  getpatientlist(context) async {
    ispageloading = true;
    try {
      patient = await ntop.getpatientlist(context);
    } catch (e) {
      ispageloading = false;
    }
    
    ispageloading = false;
    notifyListeners();
  }
}
