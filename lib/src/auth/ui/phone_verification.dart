import 'package:flutter/material.dart';
import '../firebase/auth_services.dart';

class PhoneVerificationPage extends StatefulWidget {
  final String phoneVerificationId;
  const PhoneVerificationPage({super.key, required this.phoneVerificationId});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  @override
  void dispose() {
    _otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _otpController,
              decoration: const InputDecoration(
                hintText: "Enter OTP",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _auth.signInWithPhone(widget.phoneVerificationId,
                        _otpController.text, context);
                  }
                },
                child: const Text("Verify")),
          ],
        ),
      ),
    );
  }
}
