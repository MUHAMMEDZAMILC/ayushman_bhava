import 'package:flutter/material.dart';

class AppRichText extends StatelessWidget {
  final String normalText;
  final String richText;
  final TextDecoration? richdec;
  final String? fontFamily,richfontFamily;
  final Color normalTextColor, richTextColor;
  final FontWeight richFontWeight, normalFontWeight;
  final double? fontSize, richTextFontSize;
  final double? letterspace, richletterspace;

  const AppRichText(
      {Key? key,
      required this.normalText,
      required this.richText,
      this.fontFamily,this.richfontFamily,
      this.normalTextColor = Colors.black,
      this.richTextColor = Colors.black,
      this.normalFontWeight = FontWeight.w300,
      this.richFontWeight = FontWeight.normal,
      this.fontSize,
      this.richTextFontSize,
      this.letterspace,
      this.richdec,
      this.richletterspace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      overflow: TextOverflow.fade,
      TextSpan(
        children: [
          TextSpan(
              text: normalText,
              style: TextStyle(
                  color: normalTextColor,
                  fontSize: fontSize ?? 12,
                  fontWeight: normalFontWeight,
                  fontFamily: fontFamily,
                  letterSpacing: letterspace)),
          TextSpan(
            text: richText,
            style: TextStyle(
              decoration: richdec,
                color: richTextColor,
                fontSize: richTextFontSize ?? (fontSize ?? 12),
                fontWeight: richFontWeight,
                fontFamily: richfontFamily,
                letterSpacing: richletterspace),
          ),
          TextSpan(
            text: ' (10%)',
            style: TextStyle(
                color: richTextColor,
                fontSize: richTextFontSize ?? (fontSize ?? 12),
                fontWeight: richFontWeight,
                fontFamily: richfontFamily,
                letterSpacing: richletterspace),
          ),
        ],
      ),
    );
  }
}