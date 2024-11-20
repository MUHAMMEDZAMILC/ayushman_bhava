import 'dart:async';
import 'dart:developer';
import 'package:ayushman_bhava/controller/shared_pref.dart';
import 'package:ayushman_bhava/utils/dimensions.dart';
import 'package:ayushman_bhava/utils/globalvariable.dart';
import 'package:ayushman_bhava/utils/helper/helper_screensize.dart';
import 'package:ayushman_bhava/utils/string.dart';
import 'package:ayushman_bhava/view/ui/auth/loginpage.dart';
import 'package:ayushman_bhava/view/ui/home/homepage.dart';
import 'package:flutter/material.dart';

import '../../../utils/helper/pagenavigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initsplash(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: SizedBox(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil.screenHeight,
        child: Stack(
          children: [
            SizedBox(
                width: ScreenUtil.screenWidth,
                height: ScreenUtil.screenHeight,
                child: Image.asset(
                  'assets/images/splashbg.png',
                  fit: BoxFit.cover,
                )),
            SizedBox(
                width: ScreenUtil.screenWidth,
                height: ScreenUtil.screenHeight,
                child: Image.asset(
                  'assets/images/greenbg.png',
                  fit: BoxFit.cover,
                )),
            Center(
              child: SizedBox(
                  width: splashlogowidth,
                  height: splashlogoheight,
                  child: Image.asset(
                    'assets/images/logo.png',
                  )),
            )
          ],
        ),
      ),
    );
  }

  initsplash( context) async {
    
    // int? userid = await SharedPref.getint(useridkey);
   
    Timer(
      const Duration(seconds: 3),
      () async{
        String? token = await SharedPref.getstring(logintokenkey);
        if (token != null && token != '') {
          log(token);
          logintoken = token;
          // userId = userid;
          Screen.openAsNewPage(context, const HomeScreen());
        } else {
          Screen.openAsNewPage(context, const LoginScreen());
        }
      },
    );
  }
}
