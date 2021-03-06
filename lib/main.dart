import 'package:edwom/home_page.dart';
import 'package:edwom/firebase_options.dart';
import 'package:edwom/widgets/auth_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_pages/sign_in_page.dart';
import 'auth_pages/sign_up_page.dart';
import 'pages/admin/admin_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        buttonTheme: const ButtonThemeData(
          shape: StadiumBorder(),
        ),
        brightness: Brightness.dark,
      ),

      routes: {
        "/": (context) => SignInPage(),
        "/adminHomePage": (context) => const AdminHome(),
        "/signUpPage": (context) => SignUpPage(),
        "/signInPage": (context) => SignInPage(),
        "/homePage": (context) => const HomePage(),
        "/authWidget": (context) => AuthWidget(
            signInPage: (context) => SignInPage(),
            signUpPage: (context) => SignUpPage(),
            adminHomePageBuilder: (context) => const AdminHome())
      },
    );
  }
}
