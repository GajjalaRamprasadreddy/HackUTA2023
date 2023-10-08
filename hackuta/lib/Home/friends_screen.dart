import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:philia/addfirends/friends_card.dart';

import '../util/CollectionConstants.dart';
import '../util/InternetChecks.dart';
import 'cards/addCard.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<dynamic> listOfFriends = [];

  @override
  void initState() {
    super.initState();
    getListOfFriends();
  }

  void getListOfFriends() async {


    final DocumentReference documentReference =
    FirebaseFirestore.instance.collection(CollectionConstants.FRIENDS).doc(
        FirebaseAuth.instance.currentUser?.uid);
    final DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists && documentSnapshot.data() != null) {
      setState(() {
        listOfFriends = documentSnapshot["listOfFriends"];

      });
    }
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
                  Center(
                    child: Text(
                      "My Friends",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listOfFriends.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: FriendsCard(
                          profileImage: listOfFriends[index]["profileImage"], name: listOfFriends[index]["fName"],
                        ),
                      );
                    },
                  ),
                  AddCard()
                ],
              ),
            )),
      ),
    );
  }

  String? getName( Map<String,String> friend) {

    return friend["name"];
  }
}
