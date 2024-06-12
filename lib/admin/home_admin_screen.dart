// import 'package:flutter/material.dart';
// import 'package:housing/Colors/colors.dart';
// import 'package:housing/admin/admin.dart';

// class HomeScreenAdimin extends StatefulWidget {
//   const HomeScreenAdimin({super.key});
//   static const String id = '/HomeScreenAdimin';
//   @override
//   State<HomeScreenAdimin> createState() => _HomeScreenAdiminState();
// }

// class _HomeScreenAdiminState extends State<HomeScreenAdimin> {
//   int selectindx = 0;
//   List<Widget> select = <Widget>[
//     const Admin_Screnn(),

//     const Admin_Screnn(),

//   ];
//   void SelectIndex(int index) {
//     setState(() {
//       selectindx = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: select[selectindx],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.admin_panel_settings), label: 'الادمن'),
//           BottomNavigationBarItem(icon: Icon(Icons.more), label: 'المزيد'),
//         ],
//         currentIndex: selectindx,
//         selectedItemColor: backgroundColor,
//         unselectedItemColor: backgroundColor,
//         showUnselectedLabels: true,
//         onTap: SelectIndex,
//       ),
//     );
//   }
// }
