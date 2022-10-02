import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/order.dart';
import '../../providers.dart';
import '../../widgets/empty_widget.dart';

class UserOrders extends ConsumerWidget {
  const UserOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFE7E3E0,
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFE7E3E0),
        title: const Center(
          child: Text('My Orders'),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Order>>(
          stream: ref
              .read(databaseProvider)!
              .getSpecificeOrders(FirebaseAuth.instance.currentUser?.uid ?? ''),
          builder: (context, snapshot) {
            // return const Center(child: CircularProgressIndicator());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading data'),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('You have no orders'));
              }
              if (snapshot.data != null) {
                return _OrderBody(
                    orders: snapshot.data!.docs.map((e) => e.data()).toList());
              }
            }
            return Container();
          }),
    );
  }
}

class _OrderBody extends StatelessWidget {
  final List<Order> orders;

  const _OrderBody({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(8.5),
              child: ListTile(
                title: Text(
                  orders[index].products.map((e) => e.name).join(', '),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  orders[index].createdAt.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                trailing: Text(
                  "\$" + orders[index].price.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ));
        });
  }
}
