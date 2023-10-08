import 'package:flutter/material.dart';
import 'package:philia/router/route_names.dart';

class AddCard extends StatelessWidget {


  const AddCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(addFriendsRoute);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          elevation: 20,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.all(3.0),
            decoration:
            BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Card(
                      child: Icon(Icons.add_circle),
                    ),
                  ),
                ),
                Text(
                  "Add Friends",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
