import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calculator/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_services.dart';
import 'dashboard_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final String routeName = 'login';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirm_password = TextEditingController();

  bool loading = false;

  void registerUser() async {
    ApiResponse response = await register(
      name.text,
      email.text,
      password.text,
    );
    print(response);
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userid', user.id ?? 0);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DashboardPage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Create New Account"),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()))
                  },
              icon: Icon(Icons.login_rounded))
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text("Register your account".toUpperCase(),
                  style: GoogleFonts.bebasNeue(fontSize: 28)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                      controller: name,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter name' : null,
                      decoration: kInputDecoration('Name', Icons.person)),
                ),
              ),
              SizedBox(height: 10),
              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: email,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter email' : null,
                    decoration: kInputDecoration('Email Address', Icons.email),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    validator: (val) =>
                        val!.isEmpty ? 'Password is required' : null,
                    decoration: kInputDecoration('Password', Icons.key),
                  ),
                ),
              ),
              //login button
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: confirm_password,
                    obscureText: true,
                    validator: (val) =>
                        val != password.text ? 'Password does not match' : null,
                    decoration: kInputDecoration('Confirm Password', Icons.key),
                  ),
                ),
              ),
              //login button
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => {
                  if (_formKey.currentState != null)
                    {
                      if (_formKey.currentState!.validate())
                        {
                          setState((() {
                            loading = true;
                            registerUser();
                          }))
                        }
                    }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: !loading
                      ? Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(241, 75, 121, 180),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text("Create Account",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account?",
                        style: GoogleFonts.bebasNeue(fontSize: 16)),
                    SizedBox(width: 3),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text("Log in",
                          style: GoogleFonts.bebasNeue(color: Colors.blue)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
