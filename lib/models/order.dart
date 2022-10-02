import 'package:cloud_firestore/cloud_firestore.dart';

import '../product.dart';

class Order {
  String id;
  double price;
  String uid;
  String email;
  DateTime createdAt;
  List<Product> products;

  Order(
      {required this.id,
      required this.price,
      required this.createdAt,
      required this.products,
      required this.email,
      required this.uid});

  Order.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        price = data['price'],
        uid = data['uid'],
        email = data['email'] ?? '',
        createdAt = (data['createdAt']).toDate(),
        products =
            (data['products'] as List).map((e) => Product.fromMap(e)).toList();

  Map<String, dynamic> toJson() => {
        'price': price,
        'uid': uid,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'products': products.map((e) => e.toMap(e.id ?? '')).toList()
      };

  // factory Order.fromMap(Map<String, dynamic> map) {
  //   final currentTime = Timestamp.fromMicrosecondsSinceEpoch(
  //       DateTime.now().millisecondsSinceEpoch);
  //   final timeStamps =
  //       map['timestamp'] == null ? currentTime : map['timestamp'] as Timestamp;

  //   return Order(
  //     confirmationId: map['confirmationId'],
  //     timestamp: timeStamps,
  //     products: (map['products'] as List<dynamic>)
  //         .map((product) => Product.fromMap(product))
  //         .toList(),
  //   );
  // }
}









// class Order {
//   String confirmationId;
//   Timestamp timestamp;

//   List<Product> products;

//   Order({
//     required this.confirmationId,
//     required this.timestamp,
//     required this.products,
//   });

//   factory Order.fromMap(Map<String, dynamic> map) {
//     return Order(
//       confirmationId: map['confirmationId'],
//       timestamp: map['timestamp'],
//       products: (map['products'] as List<dynamic>)
//           .map((product) => Product.fromMap(product))
//           .toList(),
//     );
//   }
// }
