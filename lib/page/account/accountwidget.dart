// import 'dart:convert';

// import 'package:flutter/material.dart';
// import '../../data/model/users.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AccountWidget extends StatefulWidget {
//   const AccountWidget({super.key});

//   @override
//   State<AccountWidget> createState() => _AccountWidgetState();
// }

// class _AccountWidgetState extends State<AccountWidget> {
//   Users objUser = Users(fullname: "No data");
//   getUser() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String strUser = pref.getString("user")!;

//     if (strUser == null) {
//       objUser = Users(fullname: "No data");
//     } else {
//       objUser = User.fromJson(jsonDecode(strUser));
//     }
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     getUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Full name: ${objUser.fullname}"),
//       ),
//     );
//   }
// }
