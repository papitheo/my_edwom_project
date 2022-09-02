import 'dart:io';

import 'package:edwom/custom_input_field_fb_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../product.dart';
import '../../providers.dart';
import '../../utils/snackbar.dart';

// Create an image provider with riverpod
final addImageProvider = StateProvider<XFile?>((_) => null);

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
      final fileStorage = ref.read(storageProvider); // reference file storage
      final imageFile =
          ref.read(addImageProvider.state).state; // referece the image File

      if (storage == null || fileStorage == null || imageFile == null) {
        // make sure none of them are null
        print("Error: storage, fileStorage or imageFile is null");
        return;
      }
      // Upload to Filestorage
      final imageUrl = await fileStorage.uploadFile(
        // upload File using our
        imageFile.path,
      );
      await storage.addProduct(
        Product(
          name: titleTextEditingController.text,
          description: descriptionEditingController.text,
          price: double.parse(priceEditingController.text),
          imageUrl: imageUrl,
        ),
      );
      openIconSnackBar(
        
        context,
        "Product added successfully",
        const Icon(Icons.check, color: Colors.white),
      );
      Navigator.pop(context);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Center(
          child: Center(
            child: Text("Add Products"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(
                height: 8,
              ),
              Consumer(
                builder: (context, watch, child) {
                  final image = ref.watch(addImageProvider);
                  return image == null
                      ? const Text("No image selected")
                      : Image.file(
                          File(image.path),
                          height: 200,
                          width: 600,
                        );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: const Color(0xff033323),
                      onPressed: () async {
                        final image = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          ref.watch(addImageProvider.state).state = image;
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Upload Image"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: const Color(0xff033323),
                      onPressed: () => _addProduct(),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Add Product"),
                      ),
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
