import 'package:ecommerce_major_project/views/tabbarScreens/accepted.dart';
import 'package:ecommerce_major_project/views/tabbarScreens/pending.dart';
import 'package:ecommerce_major_project/views/tabbarScreens/rejected.dart';
import 'package:flutter/material.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({Key? key}) : super(key: key);

  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            bottom: const TabBar(indicatorWeight: 10, tabs: [
              Tab(text: 'Pending', icon: Icon(Icons.pending_actions_rounded)),
              Tab(text: 'Accepted', icon: Icon(Icons.check_circle)),
              Tab(text: 'Rejected', icon: Icon(Icons.cancel))
            ]),
            title: const Text('Booking list')),
        body: const TabBarView(
          children: [Pending(), Accepted(), Rejected()],
        ),
      ),
    );
  }
}
