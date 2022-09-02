import 'package:edwom/home_page.dart';
import 'package:edwom/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key? key,
    required this.signInPage,
    required this.signUpPage,
    required this.adminHomePageBuilder,
  }) : super(key: key);

  final WidgetBuilder signInPage;
  final WidgetBuilder signUpPage;
  final WidgetBuilder adminHomePageBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    const adminEmail = "admin@admin.com";
    return authStateChanges.when(
        data: (user) => user != null
            ? user.email == adminEmail
                ? adminHomePageBuilder(context)
                :  HomePage()
            : signUpPage(context),
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
}
