// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:my_calculator/models/api_response.dart';
import 'package:my_calculator/pages/dashboard_page.dart';
import 'package:my_calculator/pages/register_page.dart';
import 'package:my_calculator/services/user_services.dart';
import 'package:my_calculator/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

import '../constants/constant.dart';
import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String routeName = 'login';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  bool loading = false;

  void checkIfUserIsLoggedIn() async {
    String token = await getToken();
    if (token != '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => DashboardPage()),
          (route) => false);
    }
  }

  void loginUser() async {
    ApiResponse response = await login(email.text, password.text);
    if (response.error == null) {
      _saveAndRedirectHome(response.data as User);
    } else {
      setState(() {
        loading = !loading;
      });
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                  SizedBox(height: 15),
                  Text('${response.error}',
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void _saveAndRedirectHome(User user) async {
    // ignore: prefer_const_constructors
    //FlutterSecureStorage pref = FlutterSecureStorage();
    //pref.write(key: "token", value: user.token ?? '');
    //pref.write(key: "userid", value: user.id ?? 0);
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userid', user.id ?? 0);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DashboardPage()),
        (route) => false);
  }

  @override
  void initState() {
    checkIfUserIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Icon(
                  Icons.apps_rounded,
                  size: 100,
                ),
                const SizedBox(height: 50),
                Text("Welcome Back ☺️!".toUpperCase(),
                    style: GoogleFonts.bebasNeue(fontSize: 28)),
                const SizedBox(height: 10),

                const SizedBox(height: 30),
                // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextFormField(
                      controller: email,
                      validator: (value) => value!.isEmpty ? '' : null,
                      decoration:
                          kInputDecoration('Email Address', Icons.email),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // password textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextFormField(
                        controller: password,
                        validator: (value) => value!.isEmpty ? '' : null,
                        obscureText: true,
                        decoration: kInputDecoration('Password', Icons.key)),
                  ),
                ),
                //login button
                const SizedBox(height: 15),
                loading
                    ? const Center(child: CircularProgressIndicator())
                    : GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                              loginUser();
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text("Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have account yet?",
                          style: GoogleFonts.bebasNeue()),
                      const SizedBox(width: 2),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: Text("Create an account",
                            style: GoogleFonts.bebasNeue(color: Colors.blue)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
