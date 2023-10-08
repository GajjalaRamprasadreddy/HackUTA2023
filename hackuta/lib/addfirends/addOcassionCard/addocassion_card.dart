import 'package:flutter/material.dart';
import 'package:philia/router/route_names.dart';

class AddOcassionsCard extends StatelessWidget {
  const AddOcassionsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 4,),
            Center(
              child: Icon(Icons.add_circle),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(

                "Add Important Ocassions",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(

                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
