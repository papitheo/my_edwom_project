import 'package:edwom/auth_pages/sign_in_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.watch(signInProvider);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFF1B232A),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 80, bottom: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign Up",
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
                        onChanged: (value) => authViewModel.email = value,
                        validator: (value) =>
                            authViewModel.emailValidator(value!),
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
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) => authViewModel.password = value,
                        cursorColor: const Color(0xFF5ED5A8),
                        obscureText: authViewModel.obscurePassword,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color(0xFF5ED5A8),
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFF5ED5A8),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              authViewModel.obscurePassword =
                                  !authViewModel.obscurePassword;
                            },
                            icon: authViewModel.obscurePassword
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Color(0xFF5ED5A8),
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    color: Color(0xFF5ED5A8),
                                  ),
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
                      const Text(
                        "Confirm Password",
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) =>
                            authViewModel.conirmPassword = value,
                        cursorColor: const Color(0xFF5ED5A8),
                        obscureText: authViewModel.obscureConfirmPassword,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: Color(0xFF5ED5A8),
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xFF5ED5A8),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              authViewModel.obscureConfirmPassword =
                                  !authViewModel.obscureConfirmPassword;
                            },
                            icon: authViewModel.obscureConfirmPassword
                                ? const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Color(0xFF5ED5A8),
                                  )
                                : const Icon(
                                    Icons.visibility_outlined,
                                    color: Color(0xFF5ED5A8),
                                  ),
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
                        height: 20,
                      ),
                      MaterialButton(
                        padding: const EdgeInsets.all(16),
                        onPressed: authViewModel.email.isNotEmpty &&
                                authViewModel.password.isNotEmpty &&
                                authViewModel.confirmPassowrd.isNotEmpty
                            ? () async {
                                if (_formKey.currentState!.validate() &&
                                    authViewModel.password ==
                                        authViewModel.confirmPassowrd) {
                                  try {
                                    await authViewModel.signUp();
                                    Navigator.pushNamed(context, '/authWidget');
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "$e",
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              }
                            : null,
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        color: const Color(0xFF5ED5A8),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Center(
                          child: Text(
                            "Or Sign Up With",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF1B232A),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: const Color(0xFF5ED5A8))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/logos/google.png",
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      const Text(
                                        "Google",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1B232A),
                                  border: Border.all(
                                    color: const Color(0xFF5ED5A8),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/logos/facebook.png",
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      const Text(
                                        "Facebook",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: "Already have an account?  ",
                              style: const TextStyle(fontSize: 17),
                              children: [
                                TextSpan(
                                    text: "Sign In",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context, '/signInPage');
                                      }),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
