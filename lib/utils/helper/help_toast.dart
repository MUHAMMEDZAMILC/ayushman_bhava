

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../view/components/apptext.dart';
import '../colors.dart';

void showcustomtoast(BuildContext context,
    {required String message,
    ToastGravity? gravity,
    Color? bgcolor,
    Color? textcolor}) {
  FToast? fToast = FToast();
  fToast.init(context);
  fToast.showToast(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 80),
          child: Container(
            decoration: BoxDecoration(
                color: bgcolor??ColorResources.BLACK, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: message,
                weight: FontWeight.w400,
                color: textcolor ?? ColorResources.WHITE,
                size: 14,
                letterspace: 0.5,
              ),
            ),
          ),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
      gravity: gravity??ToastGravity.SNACKBAR);
}

enum MessageType { error, success, warning }

void snackBar(BuildContext context,
    {required String message,
    MessageType type = MessageType.error,
    Color? kcolor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:  kcolor ?? _getColor(type),
      content: AppText(
          size: 12,
          text: message.toUpperCase(),
          color: Colors.white,
          maxline: 2)));
}
Color _getColor(MessageType type) {
  if (type == MessageType.error) {
    return Colors.red[600]!;
  } else if (type == MessageType.success) {
    return Colors.green[600]!;
  }
  return Colors.black;
}