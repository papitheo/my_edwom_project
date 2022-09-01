import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edwom/product.dart';

class FirestoreService {
  final String uid;
  FirestoreService({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(
    Product product,
  ) async {
    final docId = firestore.collection("products").doc().id;
    await firestore
        .collection("products")
        .doc(docId)
        .set(product.toMap(docId));
        
  }

  Stream<List<Product>> getProducts() {
    return firestore
        .collection("products")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Product.fromMap(d);
            }).toList());
  }

  Future<void> deleteProduct(String id) async {
    return await firestore.collection("products").doc(id).delete();
  }
}
