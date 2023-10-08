import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../addfirends/friends_card.dart';
import '../router/route_names.dart';
import '../strings/StringConstants.dart';
import '../util/AppPreference.dart';
import '../util/CollectionConstants.dart';
import '../util/greetings.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> listOfFriends = [];

  @override
  void initState() {
    super.initState();
    getListOfFriends();
  }
  void getListOfFriends() async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection(CollectionConstants.FRIENDS)
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists && documentSnapshot.data() != null) {
      setState(() {
        listOfFriends = documentSnapshot["listOfFriends"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat('DD MMM yyyy');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: <Widget>[
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SizedBox(
                                    width: width * 0.65,
                                    child: Text(
                                        "Good ${greeting()} ${AppPreference().user?.fName ?? StringConstants.no_text}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 24, color: Colors.white)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "${dateFormat.format(DateTime.now())} | ${"Location" ?? StringConstants.no_text}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(notificationRoute);
                                  },
                                  icon: const Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "My Friends",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10,),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listOfFriends.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: FriendsCard(
                      profileImage: listOfFriends[index]
                      ["profileImage"],
                      name: listOfFriends[index]["fName"],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
