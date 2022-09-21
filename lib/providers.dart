import 'package:edwom/auth_pages/auth_services.dart';
import 'package:edwom/services/payment_services.dart';
import 'package:edwom/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/firestore_services.dart';
import 'view_model/cart_view_model.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);


final storageProvider = Provider<StorageService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return StorageService(uid: uid);
  }
  return null;
});


final paymentProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});


final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final authServicesProvider = Provider<AuthenticationService>(
  (ref) => AuthenticationService(
    ref.read(firebaseAuthProvider),
  ),
);

final authStateProvider = StreamProvider((ref) {
  return ref.watch(authServicesProvider).authStateChange;
});

final databaseProvider = Provider<FirestoreService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  

  String? uid = auth.asData?.value?.uid;
  if (uid != null) {
    return FirestoreService(uid: uid);
  }
  return null;
});

final bagProvider = ChangeNotifierProvider<BagViewModel>((ref) {
  return BagViewModel();
});