import 'package:chat_app/screens/register.dart';
import 'package:chat_app/widgets/constant.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

  bool isLoadin = false;

  String? password;

  Future<void> signIn() async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

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
                  height: 130,
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
                      "Login",
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
                  onChanged: (data) {
                   password = data;
                  },
                  validtor: (value) {
                    if (value!.isEmpty) {
                      return "process failed";
                    }
                  },
                  hintTeext: "Password",
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomButton(
                  onTaap: () async {
                    setState(() {
                      isLoadin = true;
                    });
                    if (formKey.currentState!.validate()) {
                      try {
                        await signIn();
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return ChatPage(email: email!,);
                      },
                    ));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                              context, "No user found for that email.");
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                          showSnackBar(context,
                              "Wrong password provided for that user.");
                        }
                      }
                    }
                    
                    // setState(() {
                    //   isLoadin = false;
                    // });
                  
                  },
                  text: "Login",
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return RegisteScreen();
                            },
                          ));
                        },
                        child: const Text(
                          "Register",
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
