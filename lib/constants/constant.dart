// ... STRINGS ...
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseURL = 'http://myapps.learning/api';
const loginURL = '$baseURL/auth/login';
const registerURL = '$baseURL/auth/register';
const logoutURL = '$baseURL/auth/logout';
const userURL = '$baseURL/auth/user';
const update_profile = '$baseURL/auth/update/profile';
const get_all_task = '$baseURL/all/task';
const get_my_task = '$baseURL/my/task';
const get_one_task = '$baseURL/one/task';
const add_new_task = '$baseURL/new/task';
const update_task = '$baseURL/update/task';
const delete_task = '$baseURL/delete/task';
const complete_task = '$baseURL/status/task';

const serverError = 'Server Error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';
const internalServerError = 'Internal Server Error';

InputDecoration kInputDecoration(String label, icon) {
  return InputDecoration(
    border: InputBorder.none,
    labelText: label,
    prefixIcon: Icon(icon),
  );
}

GestureDetector KLoginButton(String label, Function onTap) {
  return GestureDetector(
    onTap: onTap(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    ),
  );
}

// get token
Future<String> getToken() async {
  // FlutterSecureStorage pref = FlutterSecureStorage();
  // return await pref.read(key: 'token') ?? '';
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.remove('token');
}

_showModalBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: ElevatedButton(
          child: Text("Close Bottom Sheet"),
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    },
  );
}
