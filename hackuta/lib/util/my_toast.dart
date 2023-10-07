import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

void showToast(String message, BuildContext context) {
  //BotToast.showText(text: message);
  BotToast.showSimpleNotification(
      backgroundColor: Colors.indigo,
      title: message,
      duration: Duration(seconds: 4),
      subTitle: "",
      titleStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white));
}

void showWarning(String message, BuildContext context) {
  BotToast.showText(text: message);
}

void showError(String message, BuildContext context) {
  BotToast.showText(text: message);
}

void showSuccess(String message, BuildContext context) {
  BotToast.showText(text: message);
}

void showInfo(String message, BuildContext context) {
  BotToast.showText(text: message);
}
