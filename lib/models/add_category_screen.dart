import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/views/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

class Addcategory extends StatefulWidget {
  const Addcategory({Key? key}) : super(key: key);

  

  @override
  State<Addcategory> createState() => _AddcategoryState();
}

class _AddcategoryState extends State<Addcategory> {
  TextEditingController categoryController = TextEditingController();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  void _category() {
    FirebaseFirestore.instance.collection('categories').add({
      "title": categoryController.text,
    }).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Category Added',
            style: TextStyle(color: Colors.green),
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextfieldWidget(
                controllerValue: categoryController, lblText: 'Category'),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _category();
                  },
                  child: const Text('Add Category'),
                ))
          ],
        ),
      ),
    );
  }
}
