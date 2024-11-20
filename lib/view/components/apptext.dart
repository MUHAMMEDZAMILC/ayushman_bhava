// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
   AppText({
    super.key, this.googlefont,this.color,required this.text,this.size,this.letterspace,this.weight,this.family,this.textalign,this.maxline,this.textdec
  });
  String text;
  String? family;
  Color? color;
  double? size,letterspace;
  FontWeight? weight;
  TextStyle? googlefont;
  TextAlign? textalign;
  TextDecoration?textdec;
  int? maxline=1; 

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines:maxline ,
      overflow: TextOverflow.ellipsis,
      style: googlefont??TextStyle(
        decoration: textdec,
        color: color,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: letterspace,
        fontFamily: family??'Poppins',
      ),
      textAlign:textalign?? TextAlign.start,
    );
  }
}