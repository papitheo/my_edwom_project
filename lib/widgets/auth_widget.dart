import 'package:edwom/home_page.dart';
import 'package:edwom/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_data.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key? key,
    required this.signedInBuilder,
    required this.nonSignedInBuilder,
    required this.adminSignedInBuilder,
  }) : super(key: key);

  final WidgetBuilder signedInBuilder;
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder adminSignedInBuilder;

  final String adminEmail = "admin@admin.com";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    //check if the user exists and if not save it
    return authStateChanges.when(
        data: (user) => user != null
            ? signedInHandler(context, ref, user)
            : nonSignedInBuilder(context),
        error: (_, __) => const Scaffold(
                body: Center(
              child: Text("Something went wrong!"),
            )),
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  FutureBuilder<UserData?> signedInHandler(
    context,
    WidgetRef ref,
    User user,
  ) {
    final database = ref.read(databaseProvider)!;
    final potentialUserFuture = database.getUser(user.uid);
    return FutureBuilder<UserData?>(
        future: potentialUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final potentialUser = snapshot.data;
            if (potentialUser == null) {
              database.addUser(UserData(
                  email: user.email != null ? user.email! : "",
                  uid: user
                      .uid),); // no need to await as you don't depend on that
            }
            if (user.email == adminEmail) {
              return adminSignedInBuilder(context);
            }
            return HomePage();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
