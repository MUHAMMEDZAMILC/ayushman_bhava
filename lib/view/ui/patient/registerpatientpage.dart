// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:developer';

import 'package:ayushman_bhava/model/patientpost_model.dart';
import 'package:ayushman_bhava/model/treatmentlistmodel.dart';
import 'package:ayushman_bhava/utils/colors.dart';
import 'package:ayushman_bhava/utils/dimensions.dart';
import 'package:ayushman_bhava/utils/extensions/space_ext.dart';
import 'package:ayushman_bhava/utils/helper/help_datepicker.dart';
import 'package:ayushman_bhava/utils/helper/help_loader.dart';
import 'package:ayushman_bhava/utils/helper/help_toast.dart';
import 'package:ayushman_bhava/utils/helper/helper_screensize.dart';
import 'package:ayushman_bhava/utils/helper/pagenavigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controller/service/provider/provideroperation.dart';
import '../../../model/patientlistmodel.dart';
import '../../../utils/helper/hemper_pdfmaker.dart';
import '../../components/appbutton.dart';
import '../../components/appdropdown.dart';
import '../../components/apptext.dart';
import '../../components/apptextfeild.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  bool ispageloading = true;
  TextEditingController nameCtrl = TextEditingController(),
      whatsCtrl = TextEditingController(),
      addCtrl = TextEditingController(),
      branchCtrl = TextEditingController(),
      totalCtrl = TextEditingController(),
      discCtrl = TextEditingController(),
      advanCtrl = TextEditingController(),
      maleCtrl = TextEditingController(text: '0'),
      femaleCtrl = TextEditingController(text: '0'),
      dmaleCtrl = TextEditingController(),
      dfemaleCtrl = TextEditingController(),
      treatdateCtrl = TextEditingController(),
      treathourCtrl = TextEditingController(),
      treatminuteCtrl = TextEditingController(),
      balanCtrl = TextEditingController();
  String? branch,location,payment='Cash';
  Branch? selbranch;

  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    final service = Provider.of<ProviderOperation>(context, listen: false);
    await service.getbranchlist(context);
    await service.gettreatmentlist(context);
    ispageloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ProviderOperation>(context, listen: false);
    final liveservice = Provider.of<ProviderOperation>(context, listen: true);
    // liveservice.isbtnloading=false;
    ScreenUtil.init(context);
    return ispageloading
        ? const PageEntryLoader()
        : Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    'assets/images/bell.svg',
                  ),
                )
              ],
           bottom:    PreferredSize(
            preferredSize: Size(ScreenUtil.screenWidth!*1, 50),
            child: Container(
              width: ScreenUtil.screenWidth,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                  color: ColorResources.BLACK.withOpacity(0.2)
                ))
              ),
              child: Padding(
                padding: const EdgeInsets.all(padding20),
                child: AppText(text: 'Register',size:24,weight:FontWeight.w600 ,color: ColorResources.LOGINHEAD,),
              ),
            ),
          ),
            ),
            body: SizedBox(
              width: ScreenUtil.screenWidth,
              height: ScreenUtil.screenHeight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(padding20),
                  child: Column(
                    children: [
                      gap20,
                      AppTextFeild(
                          label: "Name",
                          hinttext: "Enter your Full Name",
                          controller: nameCtrl),
                      gap20,
                      AppTextFeild(
                          type: TextInputType.number,
                          label: "Whatsapp Number",
                          hinttext: "Enter your whatsapp number",
                          controller: whatsCtrl),
                      gap20,
                      AppTextFeild(
                          label: "Address ",
                          hinttext: "Enter your full address",
                          controller: addCtrl),
                      gap20,
                      MyAppDropDown(
                        value: location,
                        items: const [
                          'Mankavu','Nadakkavu','Beach',
                        ],
                        onChange: (value) {
                          location = value ?? '';
                        
                          setState(() {});
                        },
                        label: "Location",
                        hint: "Select Location",
                      ),
                     
                      gap20,
                      MyAppDropDown(
                        value: branch,
                        items: liveservice.branchlist
                            .map((e) => e.name.toString())
                            .toList(),
                        onChange: (value) {
                          branchCtrl.text = value ?? '';
                          branch = value ?? '';
                          for (var i = 0;
                              i < liveservice.branchlist.length;
                              i++) {
                            if (branch ==
                                liveservice.branchlist[i].name.toString()) {
                              selbranch = liveservice.branchlist[i];
                              log(selbranch!.id.toString());
                            }
                          }
                          setState(() {});
                        },
                        label: "Branch",
                        hint: "Select the Branch",
                      ),
                      gap20,
                      const Row(
                        children: [
                          Text(
                            "Tretment",
                            style: TextStyle(
                                color: ColorResources.LOGINHEAD,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: liveservice.seltreatmentslist.length,
                          itemBuilder: (context, index) {
                            Treatment data =
                                liveservice.seltreatmentslist[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: paddingTiny),
                              child: Container(
                                width: ScreenUtil.screenWidth,
                                decoration: BoxDecoration(
                                  color: ColorResources.CONTAINERGREYCOLOR,
                                  borderRadius: BorderRadius.circular(8.53),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: AppText(
                                              text: "${index + 1}. ${data.name}",
                                              color: ColorResources.BLACK,
                                              weight: FontWeight.w500,
                                              maxline: 1,
                                              size: 18,
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    await service.addtreatments(
                                                        context,
                                                        isremve: true,
                                                        removetreat: data);
                                                    totalCtrl.text = service
                                                        .totoalpaymentamt
                                                        .toString();
                                                  },
                                                  child: SvgPicture.asset(
                                                    'assets/images/redclose.svg',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      10.hBox,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          AppText(
                                            text: 'Male',
                                            color: ColorResources.TEXTGREEN,
                                            size: 16,
                                            weight: FontWeight.w400,
                                          ),
                                          Container(
                                            width: 44,
                                            height: 26,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorResources.BLACK
                                                      .withOpacity(0.2)),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: AppText(
                                              text: '${data.male ?? 0}',
                                              weight: FontWeight.w400,
                                              textalign: TextAlign.center,
                                            ),
                                          ),
                                          AppText(
                                            text: 'Female',
                                            color: ColorResources.TEXTGREEN,
                                            size: 16,
                                            weight: FontWeight.w400,
                                          ),
                                          Container(
                                            width: 44,
                                            height: 26,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorResources.BLACK
                                                      .withOpacity(0.2)),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: AppText(
                                              text: '${data.female ?? 0}',
                                              weight: FontWeight.w400,
                                              textalign: TextAlign.center,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              service.seltreatment = data;
                                              service.treatment = data.name;
                                              await addtreatment(context);
                                              totalCtrl.text = service
                                                  .totoalpaymentamt
                                                  .toString();
                                            },
                                            child: SvgPicture.asset(
                                              'assets/images/editic.svg',
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      10.hBox,
                      AppButton(
                          btncolor:
                              ColorResources.BUTTONBGLIGHT.withOpacity(0.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: ColorResources.BLACK,
                              ),
                              AppText(
                                  text: 'Add Treatment',
                                  color: ColorResources.BLACK,
                                  size: 17,
                                  letterspace: 0.1,
                                  weight: FontWeight.w600,
                                  family: 'Poppins'),
                            ],
                          ),
                          onPressed: () async {
                            await addtreatment(context);
                            totalCtrl.text =
                                service.totoalpaymentamt.toString();
                          }),
                      gap20,
                      AppTextFeild(
                          type: TextInputType.number,
                          label: "Total Amount",
                          hinttext: "Enter Total Amount",
                          readonly: true,
                          controller: totalCtrl),
                      gap20,
                      AppTextFeild(
                        type: TextInputType.number,
                        label: "Discount Amount",
                        hinttext: "Enter Discount Amount",
                        controller: discCtrl,
                        onchange: (p0) => calculation(),
                      ),
                      gap20,
                      Row(
                        children: [
                        Radio(
                          focusColor: ColorResources.BLACK.withOpacity(0.25),
                          value: 'Cash', groupValue: payment, onChanged: (value) {
                          payment=value;
                          setState(() {
                            
                          });

                        },),
                        AppText(text: 'Cash',size: 14,weight: FontWeight.w400,),
                        const Spacer(),
                        Radio(value: 'Card', groupValue: payment, onChanged: (value) {
                          payment=value;
                          setState(() {
                            
                          });

                        },),
                        AppText(text: 'Card',size: 14,weight: FontWeight.w400,),
                        const Spacer(),
                        Radio(value: 'Upi', groupValue: payment, onChanged: (value) {
                          payment=value;
                          setState(() {
                            
                          });

                        },),AppText(text: 'UPI',size: 14,weight: FontWeight.w400,)
                      ],),20.hBox,
                      AppTextFeild(
                          type: TextInputType.number,
                          label: "Advance Amount ",
                          hinttext: "Enter Advance Amount",
                          controller: advanCtrl,
                          onchange: (p0) => calculation()),
                      gap20,
                      AppTextFeild(
                          type: TextInputType.number,
                          label: "Balance Amount",
                          hinttext: "Enter Balence Amount",
                          readonly: true,
                          controller: balanCtrl,
                          onchange: (p0) => calculation()),
                      gap20,
                      AppTextFeild(
                        label: "Treatment Date",
                        hinttext: "Select Date",
                        suffix: const Icon(
                          CupertinoIcons.calendar,
                          color: ColorResources.PRIMARYCOLOR,
                        ),
                        readonly: true,
                        controller: treatdateCtrl,
                        ontap: () async {
                          treatdateCtrl.text = await showAppDatePicker(context,
                              isAllowFutureDate: true, isAllowPastDate: true);
                        },
                      ),
                      gap20,
                      Row(
                        children: [
                          Expanded(
                            child: AppTextFeild(
                              controller: treathourCtrl,
                              label: 'Treatment Time',
                              hinttext: 'Hour',
                              suffix: const Icon(
                                CupertinoIcons.chevron_down,
                                color: ColorResources.PRIMARYCOLOR,
                              ),
                              type: TextInputType.number,
                            ),
                          ),
                          gapHorizontal,
                          Expanded(
                            child: AppTextFeild(
                              controller: treatminuteCtrl,
                              hinttext: 'Minutes',
                              suffix: const Icon(
                                CupertinoIcons.chevron_down,
                                color: ColorResources.PRIMARYCOLOR,
                              ),
                              type: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      gap20,
                      AppButton(
                        isloading: liveservice.isbtnloading,
                        onPressed: () async {
                         if (nameCtrl.text.isEmpty) {
      snackBar(context, message: 'Patient Name is required');
      return;
    }
    if (whatsCtrl.text.isEmpty) {
      snackBar(context, message: 'Whatsapp Number is required');
      return;
    }
    if (addCtrl.text.isEmpty) {
      snackBar(context, message: 'Address is required');
      return;
    }
    if (selbranch == null) {
      snackBar(context, message: 'Branch is required');
      return;
    }
    if (service.seltreatmentslist.isEmpty) {
      snackBar(context, message: 'Treatment is required');
      return;
    }
    if (service.seltreatmentslist.isEmpty) {
      snackBar(context, message: 'Treatment is required');
      return;
    }
    if (treatdateCtrl.text.isEmpty) {
      snackBar(context, message: 'Treatment date required');
      return;
    }

    PatientPost body = PatientPost();
    body.name = nameCtrl.text;
    body.excecutive = 'ex';
    body.payment =payment;
    body.phone = whatsCtrl.text;
    body.address = '${addCtrl.text} $location';
    body.totalAmount = double.parse(
        totalCtrl.text.trim() == '' ? '0.0' : totalCtrl.text.trim()).toInt().toString();
    body.discountAmount =
        double.parse(discCtrl.text.trim() == '' ? '0.0' : discCtrl.text.trim()).toInt().toString();
    body.advanceAmount = double.parse(
        advanCtrl.text.trim() == '' ? '0.0' : advanCtrl.text.trim()).toInt().toString();
    body.balanceAmount = double.parse(
        balanCtrl.text.trim() == '' ? '0.0' : balanCtrl.text.trim()).toInt().toString();
    body.dateNdTime =
        '${treatdateCtrl.text}-${treathourCtrl.text}:${treatminuteCtrl.text} AM';
    body.id = '';
    body.male = liveservice.malecount.toString();
    body.female = liveservice.femalecount.toString();
    body.branch = selbranch;
    body.treatments = liveservice.seltreatmentslist.map((e) => e.id!,).toList().join(',');
    await service.patientcreation(context, body);
    if (liveservice.issuccess) {
      Screen.close(context);
      generatePdf(context, body, service.seltreatmentslist);
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (builder) => AlertDialog(
            title: AppText(
              text: 'Registration is Failed',
              size: 18,
              weight: FontWeight.w500,
              letterspace: 0.6,
            ),
            actions: [
              CupertinoButton(
                child: AppText(text: 'Pdf generate'),
                onPressed: () {
                  Screen.close(context);
                  generatePdf(context, body, service.seltreatmentslist);
                },
              )
            ],
          ));
    }
                        },
                        child: AppText(
                          text: 'Save',
                          color: ColorResources.WHITE,
                          size: 17,
                          letterspace: 0.1,
                          weight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }


  Future<String?> addtreatment(BuildContext context) {
    return showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: StatefulBuilder(builder: (context, setsate) {
                final service =
                    Provider.of<ProviderOperation>(context, listen: false);
                final liveservice =
                    Provider.of<ProviderOperation>(context, listen: true);
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            30.hBox,
                            MyAppDropDown(
                              value: liveservice.treatment,
                              items: liveservice.treatmentlist
                                  .map((e) => e.name.toString())
                                  .toList(),
                              onChange: (value) {
                                service.selecttreatment(value);
                              },
                              label: "Choose Treatment",
                              hint: "Choose Prefered treatment",
                            ),
                            gap20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: SizedBox(
                                      height: 50,
                                      child: AppTextFeild(
                                        controller: dmaleCtrl,
                                        hinttext: 'Male',
                                        readonly: true,
                                      ),
                                    )),
                                gapHorizontalLarge,
                                Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  ColorResources.BUTTONBGCOLOR,
                                            ),
                                            width: 40,
                                            height: 40,
                                            child: Center(
                                                child: IconButton(
                                              onPressed: () {
                                                service.calgendercount(
                                                    isadd: false, ismale: true);
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                color: ColorResources.WHITE,
                                              ),
                                            )),
                                          ),
                                          gapHorizontal,
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.53),
                                                border: Border.all(
                                                    color: ColorResources.BLACK
                                                        .withOpacity(0.1),
                                                    width: 0.85),
                                                color: ColorResources
                                                    .TEXTFEILDFILL
                                                    .withOpacity(0.25),
                                              ),
                                              child: Center(
                                                  child: AppText(
                                                text:
                                                    "${liveservice.seltreatment?.male ?? 0}",
                                              )),
                                            ),
                                          ),
                                          gapHorizontal,
                                          Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                  color: ColorResources
                                                      .BUTTONBGCOLOR,
                                                  shape: BoxShape.circle),
                                              child: IconButton(
                                                  onPressed: () {
                                                    service.calgendercount(
                                                        isadd: true,
                                                        ismale: true);
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: ColorResources.WHITE,
                                                  ))),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            gap20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: SizedBox(
                                      height: 50,
                                      child: AppTextFeild(
                                        controller: dfemaleCtrl,
                                        hinttext: 'FeMale',
                                        readonly: true,
                                      ),
                                    )),
                                gapHorizontalLarge,
                                Expanded(
                                    flex: 5,
                                    child: SizedBox(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                  color: ColorResources
                                                      .BUTTONBGCOLOR,
                                                  shape: BoxShape.circle),
                                              child: IconButton(
                                                  onPressed: () {
                                                    service.calgendercount(
                                                        isadd: false,
                                                        ismale: false);
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: ColorResources.WHITE,
                                                  ))),
                                          gapHorizontal,
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.53),
                                                border: Border.all(
                                                    color: ColorResources.BLACK
                                                        .withOpacity(0.1),
                                                    width: 0.85),
                                                color: ColorResources
                                                    .TEXTFEILDFILL
                                                    .withOpacity(0.25),
                                              ),
                                              child: Center(
                                                  child: AppText(
                                                text:
                                                    "${liveservice.seltreatment?.female ?? 0}",
                                              )),
                                            ),
                                          ),
                                          gapHorizontal,
                                          Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                  color: ColorResources
                                                      .BUTTONBGCOLOR,
                                                  shape: BoxShape.circle),
                                              child: IconButton(
                                                  onPressed: () {
                                                    service.calgendercount(
                                                        isadd: true,
                                                        ismale: false);
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: ColorResources.WHITE,
                                                  ))),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            gap20,
                            AppButton(
                              onPressed: () async {
                                await service.addtreatments(context);
                                totalCtrl.text =
                                    service.totoalpaymentamt.toString();
                              },
                              child: AppText(
                                  text: 'Save',
                                  color: ColorResources.WHITE,
                                  size: 17,
                                  letterspace: 0.1,
                                  weight: FontWeight.w600,
                                  family: 'Poppins'),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 8,
                      child: InkWell(
                          onTap: () {
                            service.seltreatment = null;
                            service.treatment = null;
                            Screen.close(context);
                          },
                          child: const Icon(
                            CupertinoIcons.clear_fill,
                            color: ColorResources.RED,
                            size: 30,
                          )),
                    )
                  ],
                );
              }),
            ));
  }

  calculation() async {
    balanCtrl.text = (double.parse(
                totalCtrl.text.trim() == '' ? '0.0' : totalCtrl.text) -
            double.parse(advanCtrl.text.trim() == '' ? '0.0' : advanCtrl.text) -
            double.parse(discCtrl.text.trim() == '' ? '0.0' : discCtrl.text))
        .toStringAsFixed(2);
    setState(() {});
  }
}
