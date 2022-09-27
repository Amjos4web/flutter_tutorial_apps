// import 'package:flutter/material.dart';

// class BottomSheet extends StatelessWidget {
//   const BottomSheet({Key? key}) : super(key: key);

//   @override
//   Future build(BuildContext context) async {
//     return showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           height: 200,
//           width: double.infinity,
//           color: Colors.grey.shade200,
//           alignment: Alignment.center,
//           child: ElevatedButton(
//             child: const Text("Close Bottom Sheet"),
//             style: ElevatedButton.styleFrom(
//               onPrimary: Colors.white,
//               primary: Colors.green,
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         );
//       },
//     ).then((value) => value ?? false);
//   }
// }
