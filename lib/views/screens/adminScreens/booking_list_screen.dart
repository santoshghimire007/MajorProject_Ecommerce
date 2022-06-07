import 'package:ecommerce_major_project/models/product_model.dart';
import 'package:flutter/material.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({Key? key}) : super(key: key);

  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  List<ProductModel> _bookProducts = [
    ProductModel(
        id: 1,
        title: 'Shppify Tie and Suit',
        price: 999,
        description: 'kjsdhfjsadjlldflsdlfdddnndnndnndnsddfd',
        category: 'dfsfsdf',
        image: 'assets/images/logoe.png')
  ];

  @override
  // void initState() {
  //   _bookProducts = ProductCart.bookItems;
  //   print(_bookProducts.length);
  //   // getTotalAmount();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking list'),
        ),
        body: _bookProducts.isEmpty
            ? const Center(child: Text('No booking yet !!!'))
            : ListView.builder(
                itemCount: _bookProducts.length,
                itemBuilder: (BuildContext context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        _bookProducts[index].image,
                        height: 150,
                        width: 50,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            _bookProducts[index].description,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      trailing: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Rs: ${_bookProducts[index].price}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Reject'),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
  }
}
