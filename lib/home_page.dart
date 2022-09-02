import 'package:edwom/product_banner.dart';
import 'package:edwom/providers.dart';
import 'package:edwom/widgets/products_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E3E0),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ref.read(firebaseAuthProvider).signOut();
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                )
              ],
            )
          ],
          backgroundColor: const Color(0xFFE7E3E0),
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Colors.black,
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductBanner(),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Products",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "View all of our Products",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
             Flexible(child: ProductDisplay()),
          ],
        ),
      ),
    );
  }
}
