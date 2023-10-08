import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:philia/router/route_names.dart';
import 'package:philia/wishes/model/share_post_data.dart';

import '../api/openai/open_ai_api.dart';
import '../util/InternetChecks.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  var promptController = TextEditingController();
  var messageController = TextEditingController();
  File imageFile = File("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
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
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Create Post",
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: messageController.text.isNotEmpty,
                          child: InkWell(
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pushNamed(context, sharePostScreen,
                                    arguments: SharedPostData(
                                        path: imageFile.path,
                                        message: messageController.text));
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Preview",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: shouldShowAddImageView(),
                      replacement: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.file(
                              imageFile,
                              fit: BoxFit.cover, // use this
                            ),
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Future<dynamic> future = _getFromGallery();
                          future.then((value) => {
                                setState(() {
                                  imageFile = value;
                                })
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: const AspectRatio(
                              aspectRatio: 1,
                              child: Image(
                                image: NetworkImage(
                                    "https://cdn.pixabay.com/photo/2017/11/10/05/24/add-2935429_1280.png"),
                                fit: BoxFit.fill, // use this
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Add prompt",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: promptController,
                        keyboardType: TextInputType.text,
                        maxLines: 4,
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
                    SizedBox(
                        height: 50,
                        width: double.infinity, // Full-width button
                        child: TextButton(
                          onPressed: () async {
                            InternetChecks.showLoadingCircle(context);
                            Future<dynamic> future = generateGPT3Response(
                                promptController.text);
                            future
                                .then((value) => {_handleResponseData(value)});
                          },
                          child: const Text('Generate using Ai'),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Final message",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: messageController,
                        keyboardType: TextInputType.text,
                        maxLines: 4,
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleResponseData(value) async {
    InternetChecks.closeLoadingProgress(context);
    print("CreatePostScreen" + value);
    setState(() {
      messageController.text = value;
    });
  }

  bool shouldShowAddImageView() {
    if (imageFile.path.isNotEmpty)
      return false;
    else
      return true;
  }

  Future<File?> _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 900,
      maxWidth: 900,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      return imageFile;
    }
    return null;
  }
}
