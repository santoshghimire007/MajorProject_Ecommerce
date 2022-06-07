import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_major_project/views/screens/adminScreens/admin_products_screen.dart';
import 'package:ecommerce_major_project/views/screens/homeScreen/display_products_by_category.dart';
import 'package:flutter/material.dart';

class FirebaseCategory extends StatefulWidget {
  const FirebaseCategory({Key? key}) : super(key: key);

  @override
  State<FirebaseCategory> createState() => _FirebaseCategoryState();
}

class _FirebaseCategoryState extends State<FirebaseCategory> {
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

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: SizedBox(
                  height: 30,
                  child: ActionChip(
                      shadowColor: Colors.deepOrange,
                      backgroundColor: Colors.deepOrange,
                      onPressed: () {
                        //String chipItem = categoryList[index];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProductsScreen(
                                      ctgryValue: categoryList[index],
                                    )));
                      },
                      label: Text(
                        categoryList[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      padding: const EdgeInsets.all(8.0)),
                ));
          }),
    );
  }
}
