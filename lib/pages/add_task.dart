// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:my_calculator/constants/constant.dart';
import 'package:my_calculator/models/api_response.dart';
import 'package:my_calculator/models/task.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:my_calculator/pages/profile_page.dart';
import 'package:my_calculator/pages/show_task_page.dart';
import 'package:my_calculator/services/task_services.dart';

import '../widgets/bottom_navigation.dart';
import 'login_page.dart';

class AddTodoPage extends StatefulWidget {
  static String routeName = 'addTodo';

  final Task? task;
  final String? title;

  AddTodoPage({this.task, this.title});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  // create a global key that uniquely identifies the form element

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool loading = false;

  void createTask() async {
    ApiResponse response = await newTask(title.text, description.text);

    if (response.error == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TodoPage()));
    } else if (response.error == unauthorized) {
      logout().then((value) => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()))
          });
    } else {
      loading = false;
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

  void _editTask(int taskID) async {
    ApiResponse response = await editTask(title.text, description.text, taskID);

    if (response.error == null) {
      Navigator.of(context).pop();
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
      setState(() {
        loading = !loading;
      });
    }
  }

  @override
  void initState() {
    if (widget.task != null) {
      title.text = widget.task!.title ?? '';
      description.text = widget.task!.description ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      backgroundColor: const Color(0xFF28527a),
      bottomNavigationBar: BottomNav(),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    // ignore: prefer_const_constructors
                    padding: EdgeInsets.only(
                        left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(191, 246, 244, 244),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextFormField(
                      controller: title,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.task),
                          labelText: 'Title'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter task title';
                        }
                        return null;
                      },
                    ),
                  ),
                ),

                SizedBox(height: 10),
                // password textfield
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 15.0, top: 0.0, right: 15.0, bottom: 0.0),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(191, 246, 244, 244),
                        border: Border.all(color: Colors.white),
                      ),
                      child: TextFormField(
                        controller: description,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.note),
                          labelText: ('Description'),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter task short description';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                //login button
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: (() {
                      setState(() {
                        loading = !loading;
                      });
                      if (widget.task == null) {
                        createTask();
                      } else {
                        _editTask(widget.task!.id ?? 0);
                      }
                    }),
                    child: Text("Save Task"))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TodoPage()))
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.list_alt,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
