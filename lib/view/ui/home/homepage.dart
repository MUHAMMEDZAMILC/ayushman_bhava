import 'package:ayushman_bhava/model/patientlistmodel.dart';
import 'package:ayushman_bhava/utils/colors.dart';
import 'package:ayushman_bhava/utils/dimensions.dart';
import 'package:ayushman_bhava/utils/extensions/space_ext.dart';
import 'package:ayushman_bhava/utils/helper/help_loader.dart';
import 'package:ayushman_bhava/utils/helper/helper_screensize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/service/provider/provideroperation.dart';
import '../../components/appbutton.dart';
import '../../components/apptext.dart';
import '../../components/apptextfeild.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchCtrl = TextEditingController();
  @override
  void initState() {
    Provider.of<ProviderOperation>(context, listen: false).getpatientlist(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ProviderOperation>(context, listen: false);
    final liveservice = Provider.of<ProviderOperation>(context, listen: true);
    ScreenUtil.init(context);
    return liveservice.ispageloading? const PageEntryLoader(): Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset(
              'assets/images/bell.svg',
            ),
          )
        ],
        bottom: PreferredSize(
            preferredSize: Size(ScreenUtil.screenWidth!*1, 140),
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(
                  color: ColorResources.BLACK.withOpacity(0.2)
                ))
              ),
              child: Padding(
                padding: const EdgeInsets.all(padding20),
                child: Column(
                  children: [
                    Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: AppTextFeild(
                                    controller: searchCtrl,
                                    hinttext: 'Search for treatment',
                                    height: 50,
                                    prefix: SvgPicture.asset(
                                      
                                        'assets/images/searchic.svg',fit: BoxFit.none,),
                                  )),
                              5.wBox,
                              Expanded(
                                  child: AppButton(
                                onPressed: () {},
                                child: AppText(
                                  text: 'Search',
                                  color: ColorResources.WHITE,
                                  size: 12,
                                  letterspace: 0.1,
                                  weight: FontWeight.w500,
                                ),
                              )),
                            ],
                          ),
                          20.hBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               AppText(
                              text: 'Sort by :',
                              size: 16,
                              color: ColorResources.LOGINHEAD,
                              weight: FontWeight.w500,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(33),
                                border: Border.all(color: ColorResources.BLACK.withOpacity(0.3))
                              ),
              
                              height: 39,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: padding20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    AppText(text: 'Date',weight: FontWeight.w400,size: 15,color: ColorResources.LOGINHEAD,),
                                    gapHorizontalLarge,
                                    const Icon(CupertinoIcons.chevron_down,color: ColorResources.PRIMARYCOLOR,size: 20,)
                                  ],
                                ),
                              ),
                            ),
                          
                            ],
                          ),
                         
                  ],
                ),
              ),
            ),
          ),
        
                
      ),
      body: SizedBox(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil.screenHeight,
        child: ListView.builder(
          itemCount: liveservice.patient.length,
          itemBuilder: (context, index) {
            Patient data = liveservice.patient[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding20,vertical: padding),
            child: Container(
                  decoration: BoxDecoration(
                      color: ColorResources.CONTAINERGREYCOLOR,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            AppText(
                              text: "${data.id ?? ''}. ",
                              color: ColorResources.BLACK,
                              weight: FontWeight.w500,
                              size: 18,
                            ),
                            Expanded(
                              flex: 2,
                              child: AppText(
                                  text: data.name ?? '',
                                  color: ColorResources.BLACK,
                                  weight: FontWeight.w500,
                                  size: 18,
                                  family: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0, bottom: 10,right: padding),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          
                            children: [
                              AppText(
                                text: data.patientdetailsSet!.isNotEmpty?data.patientdetailsSet?.first.treatmentName??'':"",
                                color: ColorResources.TEXTGREEN,
                                size: 16,
                                weight: FontWeight.w300,
                                maxline: 1,
                              ),
                              10.hBox,
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/uil_calender.svg'),
                                  3.wBox,
                                  Expanded(
                                    child: AppText(
                                        text: DateFormat("yyyy-mm-dd").format(DateTime.parse(data.createdAt??DateTime.now().toString())),
                                        color: ColorResources.BLACK.withOpacity(0.5),
                                        size: 12,
                                        weight: FontWeight.w400,
                                        family: 'Poppins'),
                                  ),
                                  20.wBox,
                                  SvgPicture.asset('assets/images/person.svg'),
                                  3.wBox,
                                  Expanded(
                                    child: AppText(
                                        text: data.user ?? '',
                                        color: ColorResources.BLACK.withOpacity(0.5),
                                        size: 12,
                                        weight: FontWeight.w400,
                                        family: 'Poppins'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: ColorResources.BLACK.withOpacity(0.2),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            AppText(
                                text: 'View Booking details',
                                color: ColorResources.BLACK,
                                size: 16,
                                weight: FontWeight.w300,
                                family: 'Poppins'),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: ColorResources.TEXTGREEN,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
          );
        },),
      ),
      bottomNavigationBar: SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AppButton(
                onPressed: () {
                
                },
                child: AppText(
                    text: 'Register Now',
                    color: ColorResources.WHITE,
                    size: 17,
                    letterspace: 0.1,
                    weight: FontWeight.w600,
                    family: 'Poppins'),
              ),
            )),
    );
  }
}