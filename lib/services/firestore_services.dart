import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edwom/product.dart';
import '../models/order.dart';
import '../models/user_data.dart';

class FirestoreService {
  final String uid;
  FirestoreService({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(
    Product product,
  ) async {
    final docId = firestore.collection("products").doc().id;
    await firestore.collection("products").doc(docId).set(product.toMap(docId));
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

  Stream<List<Order>> getOrders() {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("orders")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final d = doc.data();
              return Order.fromMap(d);
            }).toList());
  }

  Future<void> deleteProduct(String id) async {
    return await firestore.collection("products").doc(id).delete();
  }

  // Future<void> addData(UserData user) async {
  //   await firestore.collection("users").doc(user.uid).set(
  //         user.toMap(),
  //       );
  // }

  Future<void> addUser(
    UserData user,
  ) async {
    await firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }

  Future<void> saveOrder(String confirmationId, List<Product> products) async {
    // Save the order in the orders collection of the user
    await firestore.collection("users").doc(uid).collection("orders").add({
      'confirmationId': confirmationId,
      'products':
          products.map((product) => product.toMap(confirmationId)).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    });
    // Save the order on an outer collection for the admin / user depending on your design decision.
    await firestore.collection("orders").doc(confirmationId).set({
      'confirmationId': confirmationId,
      'products':
          products.map((product) => product.toMap(confirmationId)).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
