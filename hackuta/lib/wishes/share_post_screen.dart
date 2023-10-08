import 'dart:io';

import 'package:flutter/material.dart';
import 'package:philia/wishes/model/share_post_data.dart';
import 'package:share/share.dart';

class SharePostScreen extends StatefulWidget {
  final SharedPostData sharedPostData;

  const SharePostScreen({
    Key? key,
    required this.sharedPostData,
  }) : super(key: key);

  @override
  State<SharePostScreen> createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {

  var messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    messageController.text = widget.sharedPostData.message;
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pop(context);
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
                            "Share",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () async {
                          final path = widget.sharedPostData.path;
                          if (path != null && path.isNotEmpty) {
                            final uri = Uri.file(path);
                            Share.shareFiles([widget.sharedPostData.path!],
                                text: messageController.text);
                          }
                        },
                        child: Icon(Icons.share))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.file(
                        File(widget.sharedPostData.path ?? ""),
                        fit: BoxFit.cover, // use this
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Would you like to do any changes?",
                    style:
                    TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.text,
                    maxLines: 10,
                    autofocus: false,
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
