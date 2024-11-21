import 'package:ayushman_bhava/controller/service/provider/providerservice.dart';
import 'package:ayushman_bhava/model/logindatamodel.dart';
import 'package:ayushman_bhava/model/patientpost_model.dart';
import 'package:ayushman_bhava/utils/colors.dart';
import 'package:ayushman_bhava/utils/globalvariable.dart';
import 'package:ayushman_bhava/utils/helper/pagenavigator.dart';
import 'package:ayushman_bhava/view/ui/home/homepage.dart';
import 'package:flutter/material.dart';

import '../../../model/patientlistmodel.dart';
import '../../../model/treatmentlistmodel.dart';
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

  //  get branch list method
  List<Branch> branchlist = [];
  getbranchlist(context) async {
    ispageloading = true;
    try {
      branchlist = await ntop.getbranchlist(context);
    } catch (e) {
      ispageloading = false;
    }

    ispageloading = false;
    notifyListeners();
  }

  //  get patients list method
  List<Treatment> treatmentlist = [];
  gettreatmentlist(context) async {
    ispageloading = true;
    try {
      treatmentlist = await ntop.gettreatmentlist(context);
    } catch (e) {
      ispageloading = false;
    }

    ispageloading = false;
    notifyListeners();
  }

  String? treatment;
  Treatment? seltreatment;
  List<Treatment> seltreatmentslist = [];
  selecttreatment(String? value) async {
    treatment = value;
    for (var i = 0; i < treatmentlist.length; i++) {
      if (treatment == treatmentlist[i].name) {
        seltreatment = treatmentlist[i];
      }
    }
    notifyListeners();
  }

  //  add or substrat gender
  calgendercount({bool ismale = true, isadd = true}) {
    if (seltreatment != null) {
      if (ismale) {
        if (isadd) {
          seltreatment?.male = (seltreatment?.male ?? 0) + 1;
        } else {
          seltreatment?.male = (seltreatment?.male ?? 0) - 1;
        }
      } else {
        if (isadd) {
          seltreatment?.female = (seltreatment?.female ?? 0) + 1;
        } else {
          seltreatment?.female = (seltreatment?.female ?? 0) - 1;
        }
      }
    }
    notifyListeners();
  }

  // add treatment from patient creation
  double totoalpaymentamt = 0.0;
  addtreatments(context, {bool isremve = false, Treatment? removetreat}) async {
     totoalpaymentamt = 0.0;
    if (isremve && removetreat != null) {
      seltreatmentslist.remove(removetreat);
      seltreatment = null;
      treatment = null;
    } else {
      if (seltreatment != null) {
        if (seltreatmentslist.contains(seltreatment)) {
          seltreatmentslist.remove(seltreatment!);
          seltreatmentslist.add(seltreatment!);
        } else {
          seltreatmentslist.add(seltreatment!);
        }
        seltreatment = null;

        treatment = null;
        Screen.close(context);
      } else {
        snackBar(context, message: 'Treatment not selected');
      }
    }
    for (var i = 0; i < seltreatmentslist.length; i++) {
      seltreatmentslist[i].totalamt = (double.parse(seltreatmentslist[i].price??'0.0')*(seltreatmentslist[i].male??0 + seltreatmentslist[i].female!));
      totoalpaymentamt+=seltreatmentslist[i].totalamt??0;
    }

    notifyListeners();
  }

  // patient Creation method
  bool issuccess =false;
  patientcreation(context,PatientPost body) async{
    issuccess =false;
    isbtnloading = true;
    notifyListeners();
   var res =  await ntop.patientcreation(context, body);
   issuccess = res['Result'];
    isbtnloading = false;
    notifyListeners();
  }
}
