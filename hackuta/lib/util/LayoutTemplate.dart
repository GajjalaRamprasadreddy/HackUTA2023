import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'MyLoadingWidget.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget child;

  const LayoutTemplate({required this.child}) : super();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFileData(),
        initialData: "Loading ..",
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.data != null && snapshot.data == "value") {
            return ResponsiveBuilder(
              builder: (context, sizingInformation) => Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                body: SafeArea(
                  child: child,
                ),
              ),
            );
          }
          return MyLoadingWidget();
        });
  }

  Future<String> getFileData() async {
    //await AppPreference().restoreLocalPreferenceData();
    return await new Future(() => "value");
  }
}
