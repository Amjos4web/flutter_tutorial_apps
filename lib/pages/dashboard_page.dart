// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_calculator/constants/constant.dart';
import 'package:my_calculator/models/api_response.dart';
import 'package:my_calculator/pages/calculator_page.dart';
import 'package:my_calculator/pages/login_page.dart';
import 'package:my_calculator/pages/show_task_page.dart';
import 'package:my_calculator/widgets/tutorial_tile.dart';
import 'package:my_calculator/widgets/bottom_navigation.dart';

import '../models/user.dart';
import '../services/user_services.dart';
import '../widgets/emoticon_faces.dart';

class DashboardPage extends StatefulWidget {
  static String routeName = 'Dashboard';

  const DashboardPage({Key? key}) : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  User? user;
  bool _loading = true;

  Future<void> getUserDetailsForHomePage() async {
    ApiResponse response = await getUserDetails();

    if (response.error == null) {
      setState(() {
        user = response.data! as User;
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
    getUserDetailsForHomePage();
    super.initState();
  }

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
                        Text(
                          'Hi, ${user?.name ?? ''}',
                          //'name',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Email: ${user?.email ?? ''}',
                          //'email',
                          style: TextStyle(color: Colors.blue[200]),
                        ),
                      ],
                    ),
                    // Notification
                    // ignore: prefer_const_constructors

                    GestureDetector(
                      onTap: () {
                        logout().then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage())));
                      },
                      child: Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          SizedBox(height: 25),

          Expanded(
              child: Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 58, 111, 176),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardPage()));
                        }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.apps_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(width: 20),
                            Text("My Learning Apps",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
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
                              color: Colors.black,
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
                              color: Colors.black,
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
                              color: Colors.black,
                            ))
                      ],
                    ),
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        EmoticonFaces("🥳"),
                        SizedBox(height: 8),
                        Text('Excellent',
                            style: TextStyle(
                              color: Colors.black,
                            ))
                      ],
                    )
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
                                  builder: (context) => TodoPage()))
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
                                  builder: (context) => DashboardPage()))
                        },
                        child: TutorialTiles(
                          icon: Icons.book_online_outlined,
                          title: "State Management",
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
