import 'package:edwom/auth_pages/sign_in_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'forgot_password_page.dart';

// ignore: use_key_in_widget_constructors
class SignInPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewProvider = ref.watch(signInProvider);

    return Stack(children: [
      Scaffold(
        backgroundColor: const Color(0xFF1B232A),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Email",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) =>
                              authViewProvider.emailValidator(value!),
                          onChanged: (value) =>
                              authViewProvider.email = value.trim(),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: const Color(0xFF5ED5A8),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFF5ED5A8),
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF5ED5A8),
                            ),
                            hintText: "Enter Your Email",
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF5ED5A8),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Password",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          onChanged: (value) =>
                              authViewProvider.password = value,
                          cursorColor: const Color(0xFF5ED5A8),
                          obscureText: authViewProvider.obscurePassword,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Color(0xFF5ED5A8),
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                authViewProvider.obscurePassword =
                                    !authViewProvider.obscurePassword;
                              },
                              icon: authViewProvider.obscurePassword
                                  ? const Icon(
                                      Icons.visibility_off_outlined,
                                      color: Color(0xFF5ED5A8),
                                    )
                                  : const Icon(
                                      Icons.visibility_outlined,
                                      color: Color(0xFF5ED5A8),
                                    ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: Color(0xFF5ED5A8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: "Enter Your Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF5ED5A8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                onPressed: authViewProvider.email.isNotEmpty &&
                                        authViewProvider.password.isNotEmpty
                                    ? () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            await authViewProvider.logIn();
                                            Navigator.pushNamed(
                                              context,
                                              '/authWidget',
                                            );
                                            // Navigator.pushReplacementNamed(
                                            //     context, Root.route);
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "$e",
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    : null,
                                color: const Color(0xFF5ED5A8),
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Don't have an account?  ",
                                children: [
                                  TextSpan(
                                      text: "Sign Up",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, '/signUpPage');
                                        }),
                                ],
                                style: const TextStyle(fontSize: 17)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      if (authViewProvider.loading)
        const Material(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          ),
        ),
    ]);
  }
}
