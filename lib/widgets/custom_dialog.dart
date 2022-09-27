import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

// class CustomDialog extends StatefulWidget {
//   const CustomDialog({Key? key}) : super(key: key);

//   @override
//   State<CustomDialog> createState() => _CustomDialogState();
// }

// class _CustomDialogState extends State<CustomDialog> {
//   @override
//   Future<Widget> build(BuildContext context) async {
//     YYDialog YYNoticeDialog() {
//       return YYDialog().build()
//         ..width = 120
//         ..height = 110
//         ..backgroundColor = Colors.black.withOpacity(0.8)
//         ..borderRadius = 10.0
//         ..showCallBack = () {
//           print("showCallBack invoke");
//         }
//         ..dismissCallBack = () {
//           print("dismissCallBack invoke");
//         }
//         ..widget(Padding(
//           padding: EdgeInsets.only(top: 21),
//           child: Image.asset(
//             'images/success.png',
//             width: 38,
//             height: 38,
//           ),
//         ))
//         ..widget(Padding(
//           padding: EdgeInsets.only(top: 10),
//           child: Text(
//             "Success",
//             style: TextStyle(
//               fontSize: 15,
//               color: Colors.white,
//             ),
//           ),
//         ))
//         ..animatedFunc = (child, animation) {
//           return ScaleTransition(
//             child: child,
//             scale: Tween(begin: 0.0, end: 1.0).animate(animation),
//           );
//         }
//         ..show();
//     }
//   }
// }
