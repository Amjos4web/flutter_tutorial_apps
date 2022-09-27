// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_calculator/constants/constant.dart';
import 'package:my_calculator/models/api_response.dart';
import 'package:my_calculator/models/task.dart';
import 'package:my_calculator/pages/add_task.dart';
import 'package:my_calculator/pages/profile_page.dart';
import 'package:my_calculator/pages/view_task.dart';
import 'package:my_calculator/services/task_services.dart';

import '../widgets/bottom_navigation.dart';
import 'login_page.dart';

class TodoPage extends StatefulWidget {
  static String routeName = 'allTodo';
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<dynamic> _taskList = [];
  bool _loading = false;

  Future<void> retriveMyTask() async {
    ApiResponse response = await getAllMyTask();

    if (response.error == null) {
      setState(() {
        _taskList = response.data as List<dynamic>;
        _loading = true;
      });
    } else if (response.error == unauthorized) {
      logout().then((value) => Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  void _handleDeleteTask(int taskID) async {
    ApiResponse response = await deleteTask(taskID);

    if (response.error == null) {
      retriveMyTask();
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

  void _completedtask(int taskID) async {
    ApiResponse response = await completeTask(taskID);

    if (response.error == null) {
      //Navigator.of(context).pop();
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
                    Icons.check_circle,
                    color: Colors.green,
                    size: 40,
                  ),
                  SizedBox(height: 15),
                  Text('${response.data}',
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
            ),
          );
        },
      );
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
    super.initState();
    retriveMyTask();
    _TodoPageState();
  }

  @override
  void setState(VoidCallback fn) {
    _TodoPageState();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks"),
      ),
      backgroundColor: const Color(0xFF28527a),
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
        child: _taskList != null
            ? Column(
                children: [
                  Expanded(
                    // RefreshIndicator(
                    //   onRefresh: () {
                    //     return retriveMyTask();
                    //   }, child: Text('jhjkhj'),
                    // ),
                    child: _loading
                        ? ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              Task task = _taskList[index];
                              return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          color: task.completed != 0
                                              ? Color.fromARGB(108, 14, 164, 57)
                                              : Color.fromARGB(
                                                  108, 177, 153, 15),
                                          //color:
                                          //Color.fromARGB(108, 14, 164, 57),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(task.title ?? '',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    )),
                                                SizedBox(height: 8),
                                                // ignore: unrelated_type_equality_checks
                                                Text(
                                                    "Status: ${task.completed == 1 ? 'Completed' : 'Started'}",
                                                    style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 12,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          PopupMenuButton(
                                              icon: Icon(Icons.more_vert,
                                                  color: Colors.white),
                                              color: Color.fromARGB(
                                                  255, 30, 66, 84),
                                              elevation: 10,
                                              itemBuilder: (BuildContext bc) {
                                                return [
                                                  PopupMenuItem(
                                                    value: 'view',
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'edit',
                                                    // ignore: prefer_const_constructors
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'delete',
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  task.completed == 0
                                                      ? PopupMenuItem(
                                                          value: 'mark',
                                                          child: Text(
                                                            "Mark As Completed",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13),
                                                          ),
                                                        )
                                                      : PopupMenuItem(
                                                          value: 'unmark',
                                                          child: Text(
                                                            "Mark As Not Completed",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13),
                                                          ),
                                                        )
                                                ];
                                              },
                                              onSelected: (val) {
                                                if (val == 'edit') {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddTodoPage(
                                                                title:
                                                                    'Edit Task',
                                                                task: task,
                                                              )));
                                                } else if (val == 'view') {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewTaskPage(
                                                                  title:
                                                                      'View Task',
                                                                  taskID:
                                                                      task.id ??
                                                                          0)));
                                                } else if (val == 'delete') {
                                                  // delete
                                                  _handleDeleteTask(
                                                      task.id ?? 0);
                                                } else {
                                                  _completedtask(task.id ?? 0);
                                                }
                                              }),
                                        ],
                                      )));
                            },
                            itemCount: _taskList.length,
                          )
                        : Center(
                            child:
                                CircularProgressIndicator(color: Colors.white)),
                  ),
                ],
              )
            : Center(
                child: Container(
                  child: Text("No Task Found",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTodoPage(
                    title: 'Create Task',
                  )))
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.add_task_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
