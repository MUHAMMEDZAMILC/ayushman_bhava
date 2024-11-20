import 'package:ayushman_bhava/model/treatmentlistmodel.dart';
import 'package:ayushman_bhava/utils/colors.dart';
import 'package:ayushman_bhava/utils/dimensions.dart';
import 'package:ayushman_bhava/utils/extensions/space_ext.dart';
import 'package:ayushman_bhava/utils/helper/help_datepicker.dart';
import 'package:ayushman_bhava/utils/helper/help_loader.dart';
import 'package:ayushman_bhava/utils/helper/helper_screensize.dart';
import 'package:ayushman_bhava/utils/helper/pagenavigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controller/service/provider/provideroperation.dart';
import '../../../model/patientlistmodel.dart';
import '../../components/appbutton.dart';
import '../../components/appdropdown.dart';
import '../../components/apptext.dart';
import '../../components/apptextfeild.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() => _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  bool ispageloading = true;
  TextEditingController nameCtrl = TextEditingController(),
      whatsCtrl = TextEditingController(),
      addCtrl = TextEditingController(),
      locaCtrl = TextEditingController(),
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
  String? branch;
  Branch? selbranch;

      @override
  void initState() {
    getdata();
    super.initState();
  }
  getdata() async{
 final service = Provider.of<ProviderOperation>(context, listen: false);
  await service.getbranchlist(context);
  await service.gettreatmentlist(context);
  ispageloading = false;
  setState(() {
    
  });
  }
  @override
  Widget build(BuildContext context) {
     final service = Provider.of<ProviderOperation>(context, listen: false);
    final liveservice = Provider.of<ProviderOperation>(context, listen: true);
    ScreenUtil.init(context);
    return ispageloading?const PageEntryLoader(): Scaffold(
      appBar:  AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(
              'assets/images/bell.svg',
            ),
          )
        ],),
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
                    AppTextFeild(
                        label: "Location",
                        hinttext: "Enter Full Name",
                        controller: locaCtrl),
                    gap20,
                    MyAppDropDown(
                      value: branch,
                      items: liveservice.branchlist
                          .map((e) => e.name.toString())
                          .toList(),
                      onChange: (value) {
                        branchCtrl.text = value ?? '';
                        branch = value ?? '';
                        for (var i = 0; i < liveservice.branchlist.length; i++) {
                          if (branch == liveservice.branchlist[i].name) {
                            selbranch = liveservice.branchlist[i];
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
                      itemBuilder: (context,index) {
                        Treatment data = liveservice.seltreatmentslist[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: paddingTiny),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text: "${index+1}. ${data.name}",
                                        color: ColorResources.BLACK,
                                        weight: FontWeight.w500,
                                        size: 18,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          service.addtreatments(context,isremve: true,removetreat: data);
                                        },
                                        child: SvgPicture.asset(
                                          'assets/images/redclose.svg',
                                        ),
                                      ),
                                    ],
                                  ),
                                  10.hBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          border:
                                              Border.all(color: ColorResources.BLACK.withOpacity(0.2)),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: AppText(text:'${ data.male??0}',weight: FontWeight.w400,textalign: TextAlign.center,),
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
                                          border:
                                              Border.all(color: ColorResources.BLACK.withOpacity(0.2)),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                         child: AppText(text:'${ data.female??0}',weight: FontWeight.w400,textalign: TextAlign.center,),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          service.seltreatment = data;
                                          service.treatment = data.name;
                                          addtreatment(context);
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
                      }
                    ),
                    10.hBox,
                    AppButton(
                        btncolor: ColorResources.BUTTONBGLIGHT.withOpacity(0.3),
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
                        onPressed: () {
                          addtreatment(context);
                        }),
                    gap20,
                    AppTextFeild(
                        type: TextInputType.number,
                        label: "Total Amount",
                        hinttext: "Enter Total Amount",
                        controller: totalCtrl),
                    gap20,
                    AppTextFeild(
                        type: TextInputType.number,
                        label: "Discount Amount",
                        hinttext: "Enter Discount Amount",
                        controller: discCtrl),
                    gap20,
                    AppTextFeild(
                        type: TextInputType.number,
                        label: "Advance Amount ",
                        hinttext: "Enter Advance Amount",
                        controller: advanCtrl),
                    gap20,
                    AppTextFeild(
                        type: TextInputType.number,
                        label: "Balance Amount",
                        hinttext: "Enter Balence Amount",
                        controller: balanCtrl),
                    gap20,
                    AppTextFeild(
                        label: "Treatment Date",
                        hinttext: "Select Date",
                        suffix: const Icon(CupertinoIcons.calendar,color: ColorResources.PRIMARYCOLOR,),
                        readonly: true,

                        controller: treatdateCtrl,ontap: () async {
                          treatdateCtrl.text = await showAppDatePicker(context,isAllowFutureDate: true,isAllowPastDate: true);
                        } ,),
                    gap20,
                    Row(
                      children: [
                        Expanded(
                          child: AppTextFeild(controller: treathourCtrl,label: 'Treatment Time',hinttext: 'Hour',suffix: const Icon(CupertinoIcons.chevron_down,color: ColorResources.PRIMARYCOLOR,),
                          type: TextInputType.number,),
                        ),gapHorizontal,
                        Expanded(
                          child: AppTextFeild(controller: treatminuteCtrl,hinttext: 'Minutes',suffix: const Icon(CupertinoIcons.chevron_down,color: ColorResources.PRIMARYCOLOR,),
                          type: TextInputType.number,),
                        ),
                      ],
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
                                  content: StatefulBuilder(
                                    builder: (context,setsate) {
                                       final service = Provider.of<ProviderOperation>(context, listen: false);
                                       final liveservice = Provider.of<ProviderOperation>(context, listen: true);
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
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
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      shape:
                                                                          BoxShape.circle,
                                                                      color: ColorResources.BUTTONBGCOLOR,),
                                                              width: 40,
                                                              height: 40,
                                                              child:  Center(
                                                                  child: IconButton(
                                                                    onPressed: () {
                                                                       service.calgendercount(isadd: false,ismale: true);
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
                                                              decoration:
                                                                   BoxDecoration(
                                                                     borderRadius: BorderRadius.circular(8.53),
                                                                     border:
                                                                Border.all(color: ColorResources.BLACK.withOpacity(0.1), width: 0.85),
                                                                      color: ColorResources.TEXTFEILDFILL.withOpacity(0.25),),
                                                             
                                                              child: Center(
                                                                  child: AppText(text: "${liveservice.seltreatment?.male??0}",)),
                                                            ),),
                                                            gapHorizontal,
                                                            Container(
                                                                width: 40,
                                                                height: 40,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: ColorResources.BUTTONBGCOLOR,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                child: IconButton(
                                                                    onPressed: () {
                                                                       service.calgendercount(isadd: true,ismale: true);
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
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
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: ColorResources.BUTTONBGCOLOR,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                child: IconButton(
                                                                    onPressed: () {
                                                                      service.calgendercount(isadd: false,ismale: false);
                                                                    },
                                                                    icon: const Icon(
                                                                      Icons.remove,
                                                                      color: ColorResources.WHITE,
                                                                    ))),
                                                            gapHorizontal,
                                                           Expanded(
                                                                child: Container(
                                                              decoration:
                                                                   BoxDecoration(
                                                                     borderRadius: BorderRadius.circular(8.53),
                                                                     border:
                                                                Border.all(color: ColorResources.BLACK.withOpacity(0.1), width: 0.85),
                                                                      color: ColorResources.TEXTFEILDFILL.withOpacity(0.25),),
                                                             
                                                              child: Center(
                                                                  child: AppText(text: "${liveservice.seltreatment?.female??0}",)),
                                                            ),),gapHorizontal,
                                                            Container(
                                                                width: 40,
                                                                height: 40,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                        color: ColorResources.BUTTONBGCOLOR,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                child: IconButton(
                                                                    onPressed: () {
                                                                      service.calgendercount(isadd: true,ismale: false);
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
                                                    onPressed: () {
                                                      service.addtreatments(context);
                                                      
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
                                                service.treatment=null;
                                                Screen.close(context);
                                              },
                                              child: const Icon(CupertinoIcons.clear_fill,color: ColorResources.RED,size: 30,)),
                                          )
                                        ],
                                      );
                                    }
                                  ),
                                ));
  }
}