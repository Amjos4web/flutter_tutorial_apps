// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_build_context_synchronously, unnecessary_null_comparison, unrelated_type_equality_checks, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:my_calculator/constants/constant.dart';
import 'package:my_calculator/models/api_response.dart';
import 'package:my_calculator/services/task_services.dart';

import '../models/task.dart';
import '../widgets/bottom_navigation.dart';
import 'login_page.dart';

class ViewTaskPage extends StatefulWidget {
  static String routeName = 'allTodo';

  int? taskID;
  String? title;

  ViewTaskPage({
    this.taskID,
    this.title,
  });

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage> {
  Task? _task;
  bool _loading = false;

  void retriveTask(int taskID) async {
    ApiResponse response = await getOneTask(taskID);

    if (response.error == null) {
      setState(() {
        _task = response.data! as Task;
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

  @override
  void initState() {
    super.initState();
    if (widget.taskID != null) {
      retriveTask(widget.taskID ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      backgroundColor: const Color(0xFF28527a),
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
        child: _task != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    _loading
                        ? Center(
                            child: Container(
                              width: 300,
                              height: 300,
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromARGB(118, 139, 190, 215)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_task?.title ?? 'Make this work!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      )),
                                  SizedBox(height: 20),
                                  Text(
                                      _task?.description ??
                                          'This is description is just a placeholder. Not working yet',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  SizedBox(height: 20),
                                  Text(
                                      _task?.completed != null
                                          ? 'This task has been completed'
                                          : 'This task is still on going',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child:
                                CircularProgressIndicator(color: Colors.white)),
                  ],
                ),
              )
            : Center(
                child: Container(
                  child: Text("Task not Found",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ViewTaskPage()))
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.list_alt_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
