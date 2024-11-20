
import 'package:flutter/material.dart';

import '../colors.dart';
import 'helper_screensize.dart';


bool isLoading = false;

class MyAppLoader extends StatelessWidget {
  const MyAppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SizedBox(
            width: ScreenUtil.screenWidth,
        height: ScreenUtil.screenHeight!*0.9,
            child: Center(child: Container(width: 80,height: 80,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: ColorResources.WHITE,boxShadow: [BoxShadow(color: ColorResources.BLACK.withOpacity(0.4),blurStyle: BlurStyle.outer,blurRadius: 5)]),child: const Center(child: CircularProgressIndicator(),),))
          );
  }
}

class PageEntryLoader extends StatelessWidget {
  const PageEntryLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ScreenUtil.screenWidth,
      height: ScreenUtil.screenHeight,
      color: ColorResources.WHITE,
      child: const Center(
        child: CircularProgressIndicator(color: ColorResources.PRIMARYCOLOR,),
      ),
    );
  }
}

void get hideKeyboard => FocusManager.instance.primaryFocus?.unfocus();