import 'package:edwom/auth_pages/sign_in_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Root extends ConsumerWidget {
  const Root({
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
    final auth = ref.read(signInProvider);
    const adminEmail = "admin@admin.com";

    return auth.user != null
        ? auth.email == adminEmail
            ? adminHomePageBuilder(context)
            : signInPage(context)
        : signUpPage(context);
  }
}
