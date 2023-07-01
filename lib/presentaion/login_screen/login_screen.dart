// // ignore_for_file: prefer_const_constructors

// import 'package:flare_video_player/colors.dart';
// import 'package:flare_video_player/login_screen/login_widget.dart';
// import 'package:flare_video_player/login_screen/signup_screen.dart';
// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController userInputEmail = TextEditingController();
//   TextEditingController userInputPassword = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Color(secondaryColor),
//           ),
//         ),
//         title: Text(
//           'Login',
//           style: TextStyle(color: Color(secondaryColor)),
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Spacer(),
//             Text(
//               'Sign In',
//               style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//             ),
//             Spacer(),
//             Text('Enter your email and password'),
//             Spacer(
//                 // flex: 2,
//                 ),
//             LoginTextFormField(
//                 userInputEmail: userInputEmail, hintText: 'Email'),
//             LoginTextFormField(
//                 userInputEmail: userInputPassword, hintText: 'Password'),
//             Spacer(
//                 // flex: 2,
//                 ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStatePropertyAll(Colors.black),
//                     ),
//                     child: Text(
//                       'LOGIN',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (ctx) => SignUpScreen()));
//               },
//               child: Row(
//                 children: const [
//                   Text(
//                     'Dont have a account ?',
//                     style: TextStyle(color: Colors.black),
//                     textScaleFactor: 1.3,
//                   ),
//                   Text(
//                     'Sign up',
//                     style: TextStyle(
//                       color: Colors.orange,
//                       decoration: TextDecoration.underline,
//                     ),
//                     textScaleFactor: 1.3,
//                   )
//                 ],
//               ),
//             ),
//             Spacer(
//               flex: 5,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
