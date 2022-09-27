// ignore_for_file: no_logic_in_create_state, prefer_const_constructors

import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  final String title;
  final String status;

  TodoList({
    Key? key,
    required this.title,
    required this.status,
  }) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState(title: title, status: status);
}

class _TodoListState extends State<TodoList> {
  late String title;
  late String status;

  _TodoListState({
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 54, 95, 134),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
                      SizedBox(height: 8),
                      Text("Status: $status",
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          )),
                    ],
                  ),
                ),
                PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    color: Color.fromARGB(255, 30, 66, 84),
                    elevation: 10,
                    itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          value: 'edit',
                          // ignore: prefer_const_constructors
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          onTap: () {},
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ];
                    },
                    onSelected: (val) {
                      if (val == 'Edit') {
                        // edit
                      } else {
                        // delete
                      }
                    }),
              ],
            )));
  }
}
