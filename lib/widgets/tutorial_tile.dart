// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TutorialTiles extends StatelessWidget {
  final icon;
  final String title;
  final String status;
  final color;

  const TutorialTiles({
    Key? key,
    this.icon,
    required this.title,
    required this.status,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                      padding: EdgeInsets.all(16),
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: color,
                      ),
                      // ignore: prefer_const_constructors
                      child: Icon(
                        icon,
                        color: Colors.white,
                      )),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: prefer_const_constructors
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(height: 8),
                    // //subtitle
                    // Text(
                    //   "Status: $status",
                    //   style: TextStyle(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.grey),
                    // ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_circle_right,
            ),
          ],
        ),
      ),
    );
  }
}
