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
      body: StreamBuilder<List<Order>>(
          stream: ref.read(databaseProvider)!.getOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.data != null) {
              if (snapshot.data!.isEmpty) {
                return const EmptyWidget();
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final order = snapshot.data![index];

                    final total = order.products
                        .map(((e) => e.price))
                        .reduce((value, element) => value + element);

                    return Padding(
                        padding: const EdgeInsets.all(8.5),
                        child: ListTile(
                          title: Text(
                            order.products.map((e) => e.name).join(', '),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            order.timestamp!.toDate().toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          trailing: Text(
                            "\$" + total.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ));
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
