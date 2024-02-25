import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PassField extends StatefulWidget {
  PassField(
      {super.key,
      required this.isObscure,
      required this.passController,
      required this.isConfirmField,
      this.pass});
  final TextEditingController passController;
  bool isObscure;
  bool isConfirmField;
  //this pass variable is used to check the value with confirm password field
  String? pass;

  @override
  State<PassField> createState() => _PassFieldState();
}

class _PassFieldState extends State<PassField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: widget.passController,
        obscureText: widget.isObscure,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your Password";
          }
          if (value.length < 8) {
            return "Minimum length of password is 8";
          }
          if (widget.isConfirmField) {
            if (value != widget.pass) {
              return "Password does not match";
            }
          }
          return null;
        },
        decoration: InputDecoration(
            suffix: IconButton(
                onPressed: () => setState(() {
                      widget.isObscure = !widget.isObscure;
                    }),
                icon: widget.isObscure
                    ? const Icon(Icons.remove_red_eye_outlined)
                    : const Icon(Icons.remove_red_eye)),
            hintText: "Enter your Password",
            prefixIcon: const Icon(Icons.password)),
      ),
    );
  }
}
