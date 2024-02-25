import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../firebase/auth_services.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController _phoneNumberController = TextEditingController();
  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                autofocus: true,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                  LengthLimitingTextInputFormatter(13),
                ],
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  hintText: "Enter Phone Number",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone number";
                  }
                  if (value.length != 13 || !value.contains("+")) {
                    return "Please enter valid phone number";
                  }

                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _auth.verifyPhoneNumber(_phoneNumberController.text, context);
                }
              },
              child: const Text("Send OTP"),
            ),
            const SizedBox(height: 10),
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}
