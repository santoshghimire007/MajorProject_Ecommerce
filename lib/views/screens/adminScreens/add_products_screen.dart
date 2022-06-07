import 'dart:io';

import 'package:ecommerce_major_project/views/widgets/textfield_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:loading_indicator/loading_indicator.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  File? _image;

  List<String> categoryList = [];

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  getCategories() async {
    await categories.get().then((QuerySnapshot<Object?> value) => {
          for (var data in value.docs)
            {
              setState(() {
                if (!categoryList.contains(data['title'])) {
                  categoryList.add(data['title']);
                }
              })
            }
        });
  }

  String dropDownValue = 'Fashion';

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  bool loader = false;

  bool stock = true;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference allproducts =
      FirebaseFirestore.instance.collection('allProducts');

  void uploadImage() {
    setState(() {
      loader = true;
    });
    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("Images").child(imageFileName);
    final UploadTask uploadTask = storageReference.putFile(_image!);

    uploadTask.then((TaskSnapshot taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        _saveData(imageUrl);
      }).catchError((error) {
        setState(() {
          loader = false;
        });
      });
    });
  }

  void _saveData(String imageUrl) {
    FirebaseFirestore.instance.collection("allProducts").add({
      "imageUrl": imageUrl,
      "name": productsNameController.text,
      "price": productsPriceController.text,
      "description": productsDescriptionController.text,
      "stock": stock,
      "category": dropDownValue,
    }).whenComplete(() {
      setState(() {
        loader = false;
      });
      _goHome();
    }).catchError((err) {
      setState(() {
        loader = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    });
  }

  _goHome() {
    Navigator.pop(context);
  }

  TextEditingController productsNameController = TextEditingController();
  TextEditingController productsPriceController = TextEditingController();
  TextEditingController productsDescriptionController = TextEditingController();
  // TextEditingController productsCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Products'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(children: <Widget>[
              _image == null
                  ? Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.grey,
                      child: Center(
                        child: ElevatedButton(
                            onPressed: () {
                              _openImagePicker();
                            },
                            child: const Text('Add Image')),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        _openImagePicker();
                      },
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        color: Colors.grey,
                        child: Image.file(
                          _image!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              TextfieldWidget(
                  controllerValue: productsNameController,
                  lblText: 'Products Name'),
              const SizedBox(
                height: 10,
              ),
              TextfieldWidget(
                controllerValue: productsPriceController,
                lblText: 'Price',
                kbType: TextInputType.number,
              ),

              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: productsDescriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      const Text('Stock'),
                      Switch(
                          value: stock,
                          onChanged: (value) {
                            setState(() {
                              stock = value;
                            });
                          })
                    ]),
                    DropdownButton<String>(
                        value: dropDownValue,
                        items: categoryList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          setState(() {
                            dropDownValue = val!;
                          });
                        })
                  ]),

              loader == true
                  ? const SizedBox(
                      height: 80,
                      width: 80,
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballClipRotateMultiple,
                          colors: [
                            // Colors.green,
                            // Colors.blue,
                            // Colors.yellow,
                            Colors.deepOrange
                          ],
                          strokeWidth: 2,
                          pathBackgroundColor: Colors.black

                          /// Optional, the stroke backgroundColor
                          ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            uploadImage();
                          },
                          child: const Text('Add Products')))

              //  TextfieldWidget(
              // controllerValue: productsCategoryController, lblText: 'Price'),
            ])));
  }
}
