

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import 'main_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    String anim = "assets/anim/wave_anim.json";
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 90,
            child: Lottie.asset(
              anim,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SignUp",
                  style: textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Create your account",
                  style: textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 25,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: textTheme.labelMedium,
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: GoogleFonts.ubuntu(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty == true) {
                            return "Enter username";
                          } else if (value.length < 5) {
                            return "Username must be minimum 5 chars";
                          } else if (value.length > 20) {
                            return "Username must be maximum 20 chars";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          style: textTheme.labelMedium,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: GoogleFonts.ubuntu(),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: const Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty == true) {
                              return "Enter Email";
                            } else if (!value.contains("@")) {
                              return "Enter a valid email";
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return TextFormField(
                              style: textTheme.labelMedium,
                              obscureText: obscure,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: GoogleFonts.ubuntu(),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  prefixIcon: const Icon(Icons.password),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure = !obscure;
                                      });
                                    },
                                    icon: Icon(obscure
                                        ? Icons.remove_red_eye
                                        : Icons.visibility_off),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty == true) {
                                  return "Enter password";
                                } else if (value.length < 5) {
                                  return "Password must be minimum 5 chars";
                                } else if (value.length > 20) {
                                  return "Password must be maximum 20 chars";
                                } else {
                                  return null;
                                }
                              });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "I am familiar with the rules of the application and I accept them",
                        style: textTheme.subtitle2?.copyWith(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState?.validate() == true){
                              SharedPreferences pref = await SharedPreferences.getInstance();
                              pref.setBool(Constants.USER_LOGGED_IN, true);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context)=>MainPage())
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text("SignUp"),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
          SizedBox(
            width: double.infinity,
            height: 90,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(180 / 360),
              child: Lottie.asset(
                anim,
                fit: BoxFit.fill,
              ),
            ),
          )
        ],
      ),
    );
  }
}
