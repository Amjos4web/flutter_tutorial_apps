// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_calculator/pages/profile_page.dart';
import 'package:my_calculator/pages/calculator_page.dart';
import 'package:my_calculator/pages/login_page.dart';
import 'package:my_calculator/pages/show_task_page.dart';
import 'package:my_calculator/widgets/tutorial_tile.dart';
import 'package:my_calculator/widgets/bottom_navigation.dart';
import '../widgets/emoticon_faces.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
          child: Column(
        children: [
          // greetings
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // Hi Jared
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "My Tutorial Apps",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "23 Aug, 2022",
                          style: TextStyle(color: Colors.blue[200]),
                        ),
                      ],
                    ),
                    // Notification
                    // ignore: prefer_const_constructors
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue[600]),
                        // ignore: prefer_const_constructors
                        child: Icon(
                          Icons.apps,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                // search bar
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue[600]),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // ignore: prefer_const_constructors
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Search",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                // SizedBox(height: 25),
                // how do you feel
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   // ignore: prefer_const_literals_to_create_immutables
                //   children: [
                //     Text(
                //       "My favorite moods",
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 18,
                //           fontWeight: FontWeight.bold),
                //     ),
                //     Icon(
                //       Icons.more_horiz,
                //       color: Colors.white,
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          SizedBox(height: 25),
          // 4 different faces
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // bad
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  EmoticonFaces("😩"),
                  SizedBox(height: 8),
                  Text('Bad',
                      style: TextStyle(
                        color: Colors.white,
                      ))
                ],
              ),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  EmoticonFaces("🙂"),
                  SizedBox(height: 8),
                  Text('Fine',
                      style: TextStyle(
                        color: Colors.white,
                      ))
                ],
              ),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  EmoticonFaces("😄"),
                  SizedBox(height: 8),
                  Text('Well',
                      style: TextStyle(
                        color: Colors.white,
                      ))
                ],
              ),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  EmoticonFaces("🥳"),
                  SizedBox(height: 8),
                  Text('Bad',
                      style: TextStyle(
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ),

          SizedBox(height: 25),

          Expanded(
              child: Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "My Learning Apps",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Icon(Icons.more_horiz)
                  ],
                ),
                SizedBox(height: 20),
                // list view
                Expanded(
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CalculatorPage()))
                        },
                        child: TutorialTiles(
                          icon: Icons.calculate_outlined,
                          title: "Simple Calculator",
                          status: "Completed",
                          color: Colors.green,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TodoPage()))
                        },
                        child: TutorialTiles(
                          icon: Icons.menu_book,
                          title: "Todo App",
                          status: "Not Started",
                          color: Colors.orange,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()))
                        },
                        child: TutorialTiles(
                          icon: Icons.login_outlined,
                          title: "Login Page Design",
                          status: "Not Started",
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      )),
    );
  }
}
