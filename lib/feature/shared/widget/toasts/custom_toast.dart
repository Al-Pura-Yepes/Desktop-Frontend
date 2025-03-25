import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static showToastNotification(
    BuildContext context, {
    required String title,
    required String description,
    Icon? icon,
    required Color bgColor,
  }) =>
      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        autoCloseDuration: const Duration(seconds: 4),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        description: RichText(text: TextSpan(text: description, style: const TextStyle(color: Colors.white))),
        alignment: Alignment.topRight,
        direction: TextDirection.ltr,
        animationDuration: const Duration(milliseconds: 300),
        icon: icon,
        showIcon: icon != null,
        primaryColor: bgColor,



        //backgroundColor: Colors.white,
        //foregroundColor: Colors.red,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8)
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 16,
            offset: Offset(0, 16),
            spreadRadius: 0,
          )
        ],
        showProgressBar: true,
        closeOnClick: true,
        pauseOnHover: true,
      );
}
