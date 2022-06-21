import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/sessionService/session_service.dart';

// ignore: must_be_immutable
class UserProfileUpdate extends StatefulWidget {
  const UserProfileUpdate({Key? key}) : super(key: key);

  @override
  _UserProfileUpdateState createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {
  TextEditingController nameController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  UserModel? updateUserData = SessionService.userData;
  File? updateProfilePicture;
  String? userDocumentId;

  @override
  void initState() {
    super.initState();
    nameController.text = updateUserData!.displayName!;
  }

  final pickerForUpdate = ImagePicker();
  Future<void> updatePp() async {
    final XFile? upImage =
        await pickerForUpdate.pickImage(source: ImageSource.gallery);
    if (upImage != null) {
      setState(() {
        updateProfilePicture = File(upImage.path);
      });
      uploadImage();
    }
  }

  void uploadImage() {
    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("Images").child(imageFileName);
    final UploadTask uploadTask =
        storageReference.putFile(updateProfilePicture!);

    uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        // _saveData(imageUrl);
      }).catchError((error) {
        setState(() {});
      });
    });
  }

  void _saveData(String imageUrl) {
    try {
      FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(SessionService.userData!.uid)
          .update({'profilePic': true});
    } catch (e) {
      print(e.toString());
    }
  }

  setAccount({required String uid}) async {
    SharedPreferences loginData = await SharedPreferences.getInstance();
    loginData.setString('uid', uid);
  }

  void updateUserInfo({required String name, var userId}) async {
    print(userId);
    try {
      await firestore
          .collection('users')
          .where('uid', isEqualTo: userId)
          .get()
          .then((value) => value.docs.map((e) => {
                setState(() {
                  userDocumentId = e.id;
                })
              }))
          .then((value) => {
                print(value),
                firestore
                    .collection('users')
                    .doc(userDocumentId)
                    .update({'displayName': nameController.text})
              })
          .then((value) => {
                firestore
                    .collection('users')
                    .doc(userDocumentId)
                    .get()
                    .then((value) => {
                          SessionService.setUserData(UserModel(
                              uid: value['uid'],
                              email: value['email'],
                              profileImage: value['profileImage'],
                              displayName: value['displayName'])),
                          setAccount(
                              uid: jsonEncode(UserModel(
                                      uid: value['uid'],
                                      email: value['email'],
                                      profileImage: value['profileImage'],
                                      displayName: value['displayName'])
                                  .toJson())),
                          setState(() {
                            updateUserData = UserModel(
                                uid: value['uid'],
                                email: value['email'],
                                profileImage: value['profileImage'],
                                displayName: value['displayName']);
                          })
                        }),
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Updated Successfully')))
              });
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    log(userDocumentId ?? 'no id');
    return Scaffold(
        appBar: AppBar(
            //primary: false,
            elevation: 0,
            backgroundColor: Colors.black54,
            actions: [
              TextButton(
                  onPressed: () {
                    updateUserInfo(
                        name: nameController.text, userId: updateUserData!.uid);
                  },
                  child: const Text('Done',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white)))
            ]),

        // ),
        body: Column(children: [
          SizedBox(
              height: 220,
              child: Stack(children: <Widget>[
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(90),
                        bottomLeft: Radius.circular(90)),
                    child: Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.black54)),
                Positioned(
                    right: 0,
                    left: 0,
                    child: Text(updateUserData!.displayName!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold))),
                Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 65,
                            backgroundImage:
                                NetworkImage(updateUserData!.profileImage))))
              ])),
          Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: <Widget>[
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Name:',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        hintText: 'Enter Name',
                        hintStyle: TextStyle(color: Colors.deepOrange)))
              ]))
        ]));
  }
}
