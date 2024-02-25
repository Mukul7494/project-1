import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../firebase/auth_services.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  //this key is used to validate the form
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

// this bool is used to show the confirm password text in case of signup
  bool signInOrNot = false;

  //it is local service to use the firebase auth services in auth firebase folder
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  bool isObscure = true;

  //this is used to dispose the controllers when this page is destroyed to avoid memory leaks
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome 👋 '),
        ),
        body: Column(
          //to make everything in the center
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: "Enter your Email",
                          prefixIcon: Icon(Icons.email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        if (value.contains("@") == false) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                          suffix: IconButton(
                              onPressed: () => setState(() {
                                    isObscure = !isObscure;
                                  }),
                              icon: isObscure
                                  ? const Icon(Icons.remove_red_eye_outlined)
                                  : const Icon(Icons.remove_red_eye)),
                          hintText: "Enter your Password",
                          prefixIcon: const Icon(Icons.password)),
                      controller: passController,
                      obscureText: isObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Password";
                        }
                        if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    signInOrNot
                        ? TextFormField(
                            decoration: InputDecoration(
                                suffix: IconButton(
                                    onPressed: () => setState(() {
                                          isObscure = !isObscure;
                                        }),
                                    icon: isObscure
                                        ? const Icon(
                                            Icons.remove_red_eye_outlined)
                                        : const Icon(Icons.remove_red_eye)),
                                hintText: "Confirm your Password",
                                prefixIcon: const Icon(Icons.password)),
                            controller: confirmPassController,
                            obscureText: isObscure,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your Password";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters";
                              }
                              if (value != passController.text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                          )
                        : Container(),
                    const SizedBox(height: 10),
                    //container is used to give margin to the button
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //singINOrNot is used here to change the methods to sign in and sing up
                      signInOrNot
                          ?
                          //if signInOrNot true then it will use sinup method

                          _auth.signUpWithEmail(
                              email: emailController.text,
                              password: passController.text)
                          : _auth.signInWithEmailAndPass(
                              email: emailController.text,
                              password: passController.text);
                      context.go('/home');
                    }
                  },
                  child: signInOrNot
                      ? const Text("Sign Up")
                      : const Text("Sign In")),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: signInOrNot
                          ? "Already have an account"
                          : "Don't have an account? ",
                    ),
                    textAlign: TextAlign.right,
                  ),
                  TextButton(
                      onPressed: () => setState(() {
                            signInOrNot = !signInOrNot;
                          }),
                      child: signInOrNot
                          ? const Text("SignIn")
                          : const Text("Create Account"))
                ],
              ),
            ),
            TextButton(
                onPressed: () => context.push('/phoneloginPage'),
                child: const Text("Login with Phone"))
          ],
        ));
  }
}
