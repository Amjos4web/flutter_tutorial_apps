// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_services.dart';
import 'login_page.dart';

class UpdateProfile extends StatefulWidget {
  String? title;
  User? user;

  UpdateProfile({
    this.title,
    this.user,
  });

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  bool _loading = false;

  void _updateProfile() async {
    ApiResponse response = await updateProfile(name.text, email.text);

    if (response.error == null) {
      setState(() {
        Navigator.of(context).pop();
        _loading = !_loading;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage())));
    } else {
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

  @override
  void initState() {
    if (widget.user != null) {
      name.text = widget.user!.name ?? '';
      email.text = widget.user!.email ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()))
                  },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: email,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter email' : null,
                      decoration:
                          kInputDecoration('Email Address', Icons.email),
                    ),
                  ),
                ),
                //login button
                SizedBox(height: 20),
                !_loading
                    ? ElevatedButton(
                        onPressed: (() {
                          setState(() {
                            _loading = !_loading;
                            _updateProfile();
                          });
                        }),
                        child: Text("Update"))
                    : CircularProgressIndicator()
              ],
            ),
          ),
        ),
      )),
    );
  }
}
