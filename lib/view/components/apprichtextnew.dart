import 'package:flutter/material.dart';

class AppRichTextNew extends StatelessWidget {
  final List<TextSpan> textlist;
  final TextAlign? textalign;
  

  const AppRichTextNew(
      {super.key,required this.textlist,this.textalign
     });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      overflow: TextOverflow.fade,
      textAlign: textalign,
      TextSpan(
        
        children:textlist
      ),
    );
  }
}