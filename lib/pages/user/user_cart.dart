import 'package:edwom/view_model/cart_view_model.dart';
import 'package:edwom/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';

class UserCart extends ConsumerWidget {
  const UserCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bagViewModel = ref.watch(bagProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFE7E3E0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Flexible(
                    child: Center(
                      child: Text(
                        "My Cart",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bagViewModel.productsBag.isEmpty
                  ? const EmptyWidget()
                  : Flexible(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final product = bagViewModel.productsBag[index];
                          return ListTile(
                            title: Text(
                              product.name,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              "\$" + product.price.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              color: Colors.grey,
                              onPressed: () {
                                bagViewModel.removeProduct(product);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        },
                        itemCount: bagViewModel.totalProducts,
                      ),
                    ),
              const Spacer(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Text(
                      "Total: \$" + bagViewModel.totalPrice.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {},
                      child: const Text("Check Out"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
