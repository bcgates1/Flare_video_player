// import 'dart:developer';

// import 'package:flare_video_player/application/bloc/grid_bloc/grid_list_bloc.dart';
// import 'package:flare_video_player/presentaion/bottom_sheet/bottom_sheet_widget.dart';
// import 'package:flare_video_player/presentaion/home_screen/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// likealert(BuildContext context, index, bottomSheetList) {
//   return showDialog(
//       context: context,
//       builder: ((ctx) {
//         return AlertDialog(
//           title: Text('like'),
//           content: Container(
//             height: MediaQuery.of(context).size.height * 0.1,
//             width: MediaQuery.of(context).size.width * 0.1,
//             child: Center(
//               child: Text('Do you want to add this video to liked list?'),
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () async {
//                 await likedBox.put(bottomSheetList[index], bottomSheetList[index]);
//                 if (bottomNavIndex == 2) {
//                   BlocProvider.of<GridListBloc>(ctx)
//                       .add(GridListEvent(blocGridViewList: likedBox.values.toList()));
//                 }
//                 Navigator.pop(context);
//               },
//               child: Text('ok'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('cancel'),
//             )
//           ],
//         );
//       }));
// }
