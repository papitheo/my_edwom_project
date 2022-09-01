import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _forgotPasswordEmail = TextEditingController();

  @override
  void dispose() {
    _forgotPasswordEmail.dispose();
    super.dispose();
  }

  Future passwordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _forgotPasswordEmail.text.trim(),
        
      );
       showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
              "Password Reset link sent."
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                e.message.toString(),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _forgotPasswordEmail,
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
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  height: 50,
                  color: const Color(0xFF5ED5A8),
                  onPressed: passwordResetEmail,
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
