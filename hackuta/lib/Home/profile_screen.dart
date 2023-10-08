import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';
import 'package:philia/model/UserInfo.dart';

import '../../util/AppPreference.dart';
import '../strings/StringConstants.dart';
import '../util/DatePickerWidget.dart';
import '../util/MyTextFieldWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Widget> widgets = List.empty(growable: true);
  final fNameController = TextEditingController();
  final fNameNode = FocusNode();
  final lNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailIDController = TextEditingController();
  final lNameNode = FocusNode();
  final mobileNumberNode = FocusNode();
  final emailIDNode = FocusNode();
  String leaveStartDateText = "";
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  FirebaseFirestore db = FirebaseFirestore.instance;
  DateTime? leaveStartDate;

  @override
  void initState() {

    super.initState();
    setState(() {

      fNameController.text = AppPreference().user?.fName ?? "";
      lNameController.text = AppPreference().user?.lName ?? "";
      emailIDController.text = AppPreference().user?.emailId ?? "";
      mobileNumberController.text = AppPreference().user?.mobileNumber ?? "";
      leaveStartDateText = AppPreference().user?.dob ?? "";
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          SystemNavigator.pop();
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.navigate_before_sharp),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        StringConstants.basic_information,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 75.0,
                      backgroundImage: NetworkImage(
                          "https://cdn.dribbble.com/users/1136598/screenshots/5980995/media/24d8d5f4e05739aaf11f714d2566fb81.gif"),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                rootWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget rootWidget(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);
    widgets.add(MyTextFieldWidget(
        controller: fNameController, node: fNameNode, label: "First name"));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(MyTextFieldWidget(
        controller: lNameController, node: lNameNode, label: "Last name"));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(MyTextFieldWidget(
        controller: emailIDController, node: emailIDNode, label: "Email Id"));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(DatePickerWidget(
      label: "",
      onDateSelected: () async {
        leaveStartDate = await DatePicker.showSimpleDatePicker(
          context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          dateFormat: "yyyy-MM-dd",
          locale: DateTimePickerLocale.en_us,
          looping: true,
        );
        setState(() {
          if (leaveStartDate != null) {
            final DateFormat formatter = DateFormat('yyyy-MM-dd');
            String formattedDate = formatter.format(leaveStartDate!);
            leaveStartDateText = formattedDate;
          }
        });
      },
      currentDate: leaveStartDateText,
    ));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(MyTextFieldWidget(
        controller: mobileNumberController,
        node: mobileNumberNode,
        label: "Mobile Number"));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(const SizedBox(
      height: 15,
    ));


    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  void saveToUserTable() async{
    Users user = Users(
        dob: leaveStartDateText,
        emailId: emailIDController.text,
        fName:fNameController.text ,
        lName: lNameController.text,
        mobileNumber: mobileNumberController.text
    );

    db.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).set(user.toMap());
  }
}
