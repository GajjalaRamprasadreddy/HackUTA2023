import 'package:flutter/material.dart';
import 'package:philia/router/route_names.dart';

import '../strings/StringConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../util/InternetChecks.dart';
import '../util/my_toast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _passwordVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Register",
                  style: const TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Register for",
                  style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF616161)),
                ),
                const SizedBox(height: 50.0),
                Text(
                  "Email Id",
                  style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF616161)),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Enter email id",
                    hintStyle: const TextStyle(color: Color(0xFFE9E9E9)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE9E9E9),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE9E9E9),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  StringConstants.password,
                  style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF616161)),
                ),
                const SizedBox(height: 10.0),

                TextFormField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    hintText: StringConstants.password,
                    hintStyle: const TextStyle(color: Color(0xFFE9E9E9)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE9E9E9),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE9E9E9),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Confirm Password",
                  style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF616161)),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    hintText: StringConstants.password,
                    hintStyle: const TextStyle(color: Color(0xFFE9E9E9)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE9E9E9),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFE9E9E9),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                      height: 50,
                      width: double.infinity, // Full-width button
                      child: ElevatedButton(
                        onPressed: () async {
                          InternetChecks.showLoadingCircle(context);
                          if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                            signUpApiCall(emailController.text,passwordController.text);
                          }else{
                            InternetChecks.closeLoadingProgress(context);
                            showToast("Some of fields seems to be wrong, Please check!", context);
                          }
                        },
                        child: const Text('Register'),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUpApiCall(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (newUser != null) {
        InternetChecks.closeLoadingProgress(context);
        showToast("Account Created", context);
        _moveToHome();
      }
    } catch (e) {
      InternetChecks.closeLoadingProgress(context);
      print(e);
    }
  }
  validateEmail(String value) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }


  void _moveToHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(homeRoute);
    });
  }

}
