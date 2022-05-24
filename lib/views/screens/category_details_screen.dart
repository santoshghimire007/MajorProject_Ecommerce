import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:ecommerce_major_project/services/apiServices/products_services.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({
    required this.categoryItem,
    Key? key,
  }) : super(key: key);

  final String categoryItem;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  List<ProductModel> _singleCat = [];
  bool _loading = false;

  _fetchSingleCategory() async {
    setState(() {
      _loading = true;
    });
    List<ProductModel> data =
        await getSingleCategory(cate: widget.categoryItem);
    setState(() {
      _singleCat = data;
      _loading = false;
    });
  }

  @override
  void initState() {
    _fetchSingleCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(widget.categoryItem.toUpperCase()),
        ),
        body: _loading == true
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: _singleCat.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      color: Colors.grey.shade200,
                      elevation: 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: Image.network(_singleCat[index].image),
                            ),
                            const SizedBox(height: 10),
                            Text(_singleCat[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                )),
                            const SizedBox(height: 10),
                            Text('Price: ${_singleCat[index].price.toString()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15))
                          ]));
                }));
  }
}
