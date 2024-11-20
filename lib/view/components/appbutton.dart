// ignore_for_file: must_be_immutable

import 'package:ayushman_bhava/view/components/apptext.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppButton extends StatelessWidget {
   AppButton({
    super.key,this.child,required this.onPressed,this.btncolor,this.textcolor,this.isloading=false
  });
  Widget? child;
  Color? btncolor,textcolor;
  bool? isloading = false;
  Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height:50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:  WidgetStatePropertyAll(btncolor?? ColorResources.BUTTONBGCOLOR),
          shadowColor: const WidgetStatePropertyAll(ColorResources.TRANSPARENT),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.52),
          ))
        ),
        onPressed: onPressed, child:isloading==true?const SizedBox(
          width: 20,
          height: 20,
          child: Center(child:CircularProgressIndicator(color: ColorResources.BORDER_SHADE,strokeWidth: 2,) ,)): child?? AppText(text: 'Login',color:textcolor?? ColorResources.WHITE,size: 17,letterspace: 0.1,weight: FontWeight.w600,)));
  }
}