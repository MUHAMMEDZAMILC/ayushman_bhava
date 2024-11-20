import 'package:ayushman_bhava/utils/extensions/space_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../model/patientlistmodel.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../components/apptext.dart';

class PatientCard extends StatelessWidget {
  const PatientCard({
    super.key,
    required this.data,
  });

  final Patient data;

  @override
  Widget build(BuildContext context) {
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
                                text: DateFormat("dd/MM/yyyy").format(DateTime.parse(data.createdAt??DateTime.now().toString())),
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
  }
}