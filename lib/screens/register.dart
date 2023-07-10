import 'package:chat_app/screens/login.dart';
import 'package:chat_app/widgets/constant.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisteScreen extends StatefulWidget {
  RegisteScreen({super.key});

  @override
  State<RegisteScreen> createState() => _RegisteScreenState();
}

class _RegisteScreenState extends State<RegisteScreen> {
  bool isLoadin = false;

  registerUser() async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }

  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoadin,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Image.asset(
                  "assets/images/scholar.png",
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Scholar chat",
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: "Pacifico"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormFieldd(
                  validtor: (value) {
                    if (value!.isEmpty) {
                      return "process failed";
                    }
                  },
                  onChanged: (data) {
                    email = data;
                  },
                  hintTeext: "Email",
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormFieldd(
                  validtor: (value) {
                    if (value!.isEmpty) {
                      return "process failed";
                    }
                  },
                  onChanged: (data) {
                    password = data;
                  },
                  hintTeext: "Password",
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ));
                  },
                  child: CustomButton(
                    onTaap: () async {
                      setState(() {
                        isLoadin = true;
                      });
                      if (formKey.currentState!.validate()) {
                        try {
                          await registerUser();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                                context, "he password provided is too weak");
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                            showSnackBar(context,
                                "The account already exists for that email.");
                          }
                        }
                        // ignore: use_build_context_synchronously
                        showSnackBar(context, "Success");
                        setState(() {
                          isLoadin = false;
                        });
                      } else {}
                    },
                    text: "Register",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account?  ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Login In",
                          style: TextStyle(
                              color: Color.fromARGB(255, 181, 218, 249)),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
