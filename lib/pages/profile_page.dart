// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:my_calculator/pages/login_page.dart';
import 'package:my_calculator/pages/update_profile.dart';
import 'package:my_calculator/widgets/bottom_navigation.dart';

import '../constants/constant.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_services.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = 'profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  bool _loading = false;

  Future<void> getUserDetailsForProfilePage() async {
    ApiResponse response = await getUserDetails();

    if (response.error == null) {
      setState(() {
        user = response.data! as User;
        _loading = true;
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
    getUserDetailsForProfilePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: _loading
                ? Column(
                    children: [
                      Center(
                          child: Image.asset('assets/images/splash.jpg',
                              fit: BoxFit.cover, width: 180)),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              )),
                          Text(user?.name ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black45,
                              ))
                        ],
                      ),
                      SizedBox(height: 25),
                      Divider(
                        height: 2,
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              )),
                          Text(user?.email ?? '',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black45,
                              ))
                        ],
                      ),
                      SizedBox(height: 30),
                      Divider(
                        height: 2,
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateProfile(
                                              title: 'Update Profile',
                                              user: user,
                                            )));
                              }),
                              child: Text(
                                'Update Profile',
                                style: TextStyle(fontSize: 16),
                              )),
                          ElevatedButton(
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage()));
                              }),
                              child: Text(
                                'Change Password',
                                style: TextStyle(fontSize: 16),
                              )),
                        ],
                      )
                    ],
                  )
                : Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
