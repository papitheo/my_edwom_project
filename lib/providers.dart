import 'package:edwom/auth_pages/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final authServicesProvider = Provider<AuthenticationService>(
    (ref) => AuthenticationService(ref.read(firebaseAuthProvider)));

final authStateProvider = StreamProvider((ref) {
  return ref.watch(authServicesProvider).authStateChange;
});
