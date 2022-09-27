import 'package:flutter/material.dart';

class EmoticonFaces extends StatelessWidget {
  final String emoticonFace;
  const EmoticonFaces(this.emoticonFace);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.blue[600]),
      // ignore: prefer_const_constructors
      child: Text(
        emoticonFace,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
