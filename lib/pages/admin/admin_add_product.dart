import 'package:edwom/custom_input_field_fb_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product.dart';
import '../../providers.dart';

class AdminAddProductPage extends ConsumerStatefulWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  final titleTextEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _addProduct() async {
      final storage = ref.read(databaseProvider);
      if (storage == null) {
        return;
      }
      await storage.addProduct(Product(
        name: titleTextEditingController.text,
        description: descriptionEditingController.text,
        price: double.parse(priceEditingController.text),
        imageUrl: "image",
      ));
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF5ED5A8),
        title: const Center(
          child: Text("Add Products"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            CustomInputFieldFb1(
              inputController: titleTextEditingController,
              hintText: "Product Name",
              labelText: "Product Name",
            ),
            const SizedBox(
              height: 15,
            ),
            CustomInputFieldFb1(
              inputController: descriptionEditingController,
              hintText: "Product Description",
              labelText: "Product Description",
            ),
            const SizedBox(
              height: 15,
            ),
            CustomInputFieldFb1(
              inputController: priceEditingController,
              hintText: "Price",
              labelText: "Price",
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: const Color(0xFF5ED5A8),
                    onPressed: () => _addProduct(),
                    child:const  Padding(
                      padding:  EdgeInsets.all(15.0),
                      child: Text("Add Product"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
