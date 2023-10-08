import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:philia/addfirends/FriendDetails.dart';
import 'package:philia/addfirends/addOcassionCard/Ocassion.dart';
import 'package:philia/util/CollectionConstants.dart';
import 'package:philia/util/MyTextFieldWidgetWithNoOfLines.dart';

import '../util/InternetChecks.dart';
import '../util/MyTextFieldWidget.dart';
import '../util/my_toast.dart';
import 'addOcassionCard/addocassion_card.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({Key? key}) : super(key: key);

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final nameController = TextEditingController();
  final nameNode = FocusNode();
  final nickNameController = TextEditingController();
  final nickNameNode = FocusNode();
  final noOfYearsController = TextEditingController();
  final noOfYearsNode = FocusNode();
  final memoriesController = TextEditingController();
  final memoriesNode = FocusNode();
  final mobileController = TextEditingController();
  final mobileNode = FocusNode();
  final somethingUniqueAboutController = TextEditingController();
  final somethingUniqueAboutNode = FocusNode();

  final TextEditingController occasionNameController = TextEditingController();

  final TextEditingController occasionDateController = TextEditingController();

  final Map<String, String> occasions = {};

  void addOccasion() {
    setState(() {
      final occasionName = occasionNameController.text;

      final occasionDate = occasionDateController.text;

      occasions[occasionName] = occasionDate;

      occasionNameController.clear();

      occasionDateController.clear();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.navigate_before),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 75.0,
                      backgroundImage: NetworkImage(
                          "https://cdn.vectorstock.com/i/1000x1000/18/11/man-profile-cartoon-vector-19491811.webp"),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                rootWidget(context),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: occasions.length,
                  itemBuilder: (context, index) {
                    final occasionName = occasions.keys.elementAt(index);

                    final occasionDate = occasions.values.elementAt(index);

                    return Card(
                      child: ListTile(
                        title: Text('Occasion: $occasionName'),
                        subtitle: Text('Date: $occasionDate'),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Add Occasion'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  controller: occasionNameController,
                                  decoration: InputDecoration(
                                      labelText: 'Occasion Name'),
                                ),
                                TextField(
                                  controller: occasionDateController,
                                  decoration: InputDecoration(
                                      labelText: 'Occasion Date'),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  addOccasion();

                                  Navigator.of(context).pop();
                                },
                                child: Text('Add Card'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: AddOcassionsCard()),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                      height: 50,
                      width: double.infinity, // Full-width button
                      child: ElevatedButton(
                        onPressed: () {

                          // save to friends collections
                          FriendDetails f = FriendDetails(
                              name: nameController.text,
                              mobileNumber: mobileController.text,
                              lisOfOcassion: occasions,
                              memories: memoriesController.text,
                              nickName: nickNameController.text,
                              noOfYears: noOfYearsController.text,
                              somethingUnique: somethingUniqueAboutController.text);
                          saveToFriends(f);
                        },
                        child: const Text('Save'),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveToFriends(FriendDetails friendDetails) async {
    InternetChecks.showLoadingCircle(context);

    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection(CollectionConstants.FRIENDS).doc(FirebaseAuth.instance.currentUser?.uid);
    final DocumentSnapshot documentSnapshot = await documentReference.get();
    if(documentSnapshot.exists && documentSnapshot.data() != null){

      List<dynamic> listOfFriends = documentSnapshot["listOfFriends"];
      listOfFriends.add(friendDetails.toMap());
      db
          .collection(CollectionConstants.FRIENDS)
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({"listOfFriends":listOfFriends})
          .then((result) {
        InternetChecks.closeLoadingProgress(context);
         Navigator.pop(context);
      }).catchError((error) {
        InternetChecks.closeLoadingProgress(context);
        showToast("Something went wrong", context);

         Navigator.pop(context);
      });
    }

  }

  Widget rootWidget(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);
    widgets.add(MyTextFieldWidget(
        controller: nameController, node: nameNode, label: "Name"));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(MyTextFieldWidget(
        controller: nickNameController,
        node: nickNameNode,
        label: "Nick Name"));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(MyTextFieldWidget(
        controller: noOfYearsController,
        node: noOfYearsNode,
        label: "Since from how many years you know him"));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(MyTextFieldWidget(
        controller: memoriesController,
        node: memoriesNode,
        label: "Some memories you have with him"));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(MyTextFieldWidget(
        controller: mobileController,
        node: mobileNode,
        label: "His Mobile Number"));
    widgets.add(const SizedBox(
      height: 15,
    ));
    widgets.add(MyTextFieldWithNoOfLines(
        maxLines: 4,
        controller: somethingUniqueAboutController,
        node: somethingUniqueAboutNode,
        label: "Something Unique or Anything you would like to add about him"));
    widgets.add(const SizedBox(
      height: 15,
    ));

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}
