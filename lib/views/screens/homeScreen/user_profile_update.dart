import 'package:flutter/material.dart';

class UserProfileUpdate extends StatefulWidget {
  const UserProfileUpdate({Key? key}) : super(key: key);

  @override
  _UserProfileUpdateState createState() => _UserProfileUpdateState();
}

class _UserProfileUpdateState extends State<UserProfileUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Your Profile'),
      ),
      body: Container(),
    );
  }
}
