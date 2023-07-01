// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';

// class LoginTextFormField extends StatelessWidget {
//   const LoginTextFormField({
//     super.key,
//     required this.userInputEmail,
//     required this.hintText,
//   });

//   final TextEditingController userInputEmail;
//   final String hintText;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
//       child: TextFormField(
//         controller: userInputEmail,
//         style: TextStyle(
//           fontSize: 20,
//           // color: Colors.blue,
//           // fontWeight: FontWeight.w600,
//         ),
//         onChanged: (value) {
//           // userInputEmail.text = value;
//           // setState(() {});
//         },
//         decoration: InputDecoration(
//           focusColor: Colors.white,
//           //add prefix icon
//           // prefixIcon: Icon(
//           //   Icons.person_outline_rounded,
//           //   color: Colors.grey,
//           // ),
//           border:
//               UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),

//           // errorText: "Enter the Email",
//           // border: OutlineInputBorder(
//           //     borderSide: BorderSide(style: BorderStyle.none)),

//           // focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
//           fillColor: Colors.grey,

//           hintText: hintText,

//           //make hint text
//           hintStyle: TextStyle(
//             color: Colors.grey,
//             fontSize: 16,
//             // fontFamily: "verdana_regular",
//             fontWeight: FontWeight.w400,
//           ),

//           //create lable
//           // labelText: 'Email',
//           //lable style
//           labelStyle: TextStyle(
//             color: Colors.grey,
//             fontSize: 16,
//             // fontFamily: "verdana_regular",
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
// }
