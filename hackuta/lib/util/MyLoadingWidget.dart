import 'package:flutter/material.dart';

class MyLoadingWidget extends StatelessWidget {
  final Color background;
  final Color color;

  const MyLoadingWidget(
      {Key? key, this.background = Colors.white12, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: background,
        color: color,
        strokeWidth: 5.0,
      ),
    );
  }
}
