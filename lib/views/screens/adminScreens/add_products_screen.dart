import 'dart:io';

import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/services/apiServices/products_services.dart';
import 'package:ecommerce_major_project/views/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  File? _image;

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
        child: Column(
          children: <Widget>[
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

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Add Products'),
              ),
            )

            //  TextfieldWidget(
            // controllerValue: productsCategoryController, lblText: 'Price'),
          ],
        ),
      ),
    );
  }
}
