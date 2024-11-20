import 'package:ayushman_bhava/controller/service/provider/provideroperation.dart';
import 'package:ayushman_bhava/model/logindatamodel.dart';
import 'package:ayushman_bhava/utils/colors.dart';
import 'package:ayushman_bhava/utils/dimensions.dart';
import 'package:ayushman_bhava/utils/helper/helper_screensize.dart';
import 'package:ayushman_bhava/utils/string.dart';
import 'package:ayushman_bhava/view/components/appbutton.dart';
import 'package:ayushman_bhava/view/components/apprichtextnew.dart';
import 'package:ayushman_bhava/view/components/apptext.dart';
import 'package:ayushman_bhava/view/components/apptextfeild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/helper/help_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrl = TextEditingController(),
      passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ProviderOperation>(context, listen: false);
    final liveservice = Provider.of<ProviderOperation>(context, listen: true);
    ScreenUtil.init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: ScreenUtil.screenWidth,
          height: ScreenUtil.screenHeight,
          child: Column(
            children: [
              SizedBox(
                width: ScreenUtil.screenWidth,
                height: ScreenUtil.screenHeight! * 0.3,
                child: Stack(
                  children: [
                    SizedBox(
                        width: ScreenUtil.screenWidth,
                        child: Image.asset(
                          'assets/images/bg2.png',
                          fit: BoxFit.cover,
                        )),
                    Center(
                        child: SizedBox(
                            child: Image.asset(
                      'assets/images/logotiny.png',
                    ))),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(padding20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          AppText(
                            text: loginheadtxt,
                            size: 24,
                            weight: FontWeight.w600,
                            color: ColorResources.LOGINHEAD,
                          ),
                          gap21,
                          AppTextFeild(
                            controller: emailCtrl,
                            label: 'Email',
                            hinttext: 'Enter your email',
                          ),
                          gap,
                          AppTextFeild(
                            controller: passwordCtrl,
                            isobsecure: true,
                            label: 'Password',
                            hinttext: 'Enter password',
                          ),
                          gap26,
                          AppButton(
                            isloading: liveservice.isbtnloading,
                            onPressed: () async {
                              if (emailCtrl.text.isNotEmpty ||
                                  passwordCtrl.text.isNotEmpty) {
                                LoginPost body = LoginPost();
                                body.username = emailCtrl.text.trim();
                                body.password = passwordCtrl.text.trim();
                                await service.loginuserfn(context, body);
                              } else {
                                snackBar(context,
                                    message: 'Please Check Email and Password');
                              }
                            },
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: AppRichTextNew(
                            textalign: TextAlign.center,
                            textlist: [
                              TextSpan(
                                  text:
                                      'By creating or logging into an account you are agreeing with our ',
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  )),
                              TextSpan(
                                  text: 'Terms and Conditions ',
                                  style: TextStyle(
                                    color: ColorResources.BLUE,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  )),
                              TextSpan(
                                  text: 'and ',
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  )),
                              TextSpan(
                                  text: 'Privacy Policy ',
                                  style: TextStyle(
                                    color: ColorResources.BLUE,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  )),
                              TextSpan(
                                  text: '.',
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
