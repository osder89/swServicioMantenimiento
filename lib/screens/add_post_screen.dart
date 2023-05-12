import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  bool _isloading = false;

  // static Future<bool> callOnFcm({required String title, required String body}) async {
  //   const postUrl = 'https://fcm.googleapis.com/fcm/send';
  //   final data = {
  //     "notification": {"title": title, "body": body},
  //     "to":
  //         "cVR_5mNNSEup6d_KbWrKDE:APA91bGb7MhpjI9KuTzhMVmwioN6HdiA2Pmvqm0HEw3KjD6R763Cfc5HVdh3BwYw7nnMPH3s325aEvPIX5qsBCLmMMulSHrtXZArldB4mX0-Kr9TP2X98Qy_MwggHo0Ut72W2ql6cbHD",
  //     "data": {
  //       "type": '0rder',
  //       "id": '28',
  //       "click_action": 'FLUTTER_NOTIFICATION_CLICK',
  //     }
  //   };
  //   headers : {
  //     HttpHeaders.contentTypeHeader : 'application/json';
  //     HttpHeaders.authorizationHeader :'key=AAAAI19gUMk:APA91bH9K7je5_mN_G9kCvM5KYxGcdyuxgyjXe4j48wzKwrGVV0RA6UeJ1nJzEC9A-lRe9B5wszEn5SaRkHuBpm0-TWAdKok4_1hGd546DyMXW5pAVXFi8IR99PvAhSlTqe30yTM1z2X';
  //   },
  //   body: jsonEncode()
  //   // final response = await http.post(Uri.parse(postUrl),
  //   //     body: json.encode(data),
  //   //     encoding: Encoding.getByName('utf-8'),
  //   //     headers: headers);
  //   // if (response.statusCode == 200) {
  //   //   print('test ok');
  //   //   return true;
  //   // } else {
  //   //   print('error notifcation');
  //   //   return false;
  //   // }
  // }
  static Future<void> sendPushNotification(
      {required String title, required String body}) async {
    FirebaseMessaging.instance.getToken().then((token) {
      print('Token: $token');
    }).catchError((e) {
      print('Error al obtener token: $e');
    });
    try {
      final data = {
        "to":
            "cVR_5mNNSEup6d_KbWrKDE:APA91bGb7MhpjI9KuTzhMVmwioN6HdiA2Pmvqm0HEw3KjD6R763Cfc5HVdh3BwYw7nnMPH3s325aEvPIX5qsBCLmMMulSHrtXZArldB4mX0-Kr9TP2X98Qy_MwggHo0Ut72W2ql6cbHD",
        "notification": {
          "title": title, //our name should be send
          "body": body,
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAI19gUMk:APA91bH9K7je5_mN_G9kCvM5KYxGcdyuxgyjXe4j48wzKwrGVV0RA6UeJ1nJzEC9A-lRe9B5wszEn5SaRkHuBpm0-TWAdKok4_1hGd546DyMXW5pAVXFi8IR99PvAhSlTqe30yTM1z2X'
          },
          body: jsonEncode(data));
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
    } catch (e) {
      print('\nsendPushNotificationE: $e');
    }
  }

  void notification() {}

  void push() {
    setState(() {
      sendPushNotification(title: 'test', body: 'test1');
    });
  }

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isloading = true;
      sendPushNotification(
          title: username, body: 'He has published an image enter to see it');
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
        //_cantidadController.text,
        _priceController.text,
      );
      if (res == "success") {
        setState(() {
          _isloading = false;
        });
        showSnackBar('Posted!', context);
        clearImage();
      } else {
        setState(() {
          _isloading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => postImage(
                    user.uid,
                    user.username,
                    user.photoUrl,
                  ),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                _isloading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      hintText: 'Enter the price...',
                      border: InputBorder.none,
                    ),
                    maxLines: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider()
                  ],
                ),
              ],
            ),
          );
  }
}
