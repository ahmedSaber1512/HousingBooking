// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:housing/Colors/colors.dart';
// import 'package:housing/user/housing_item.dart';
// import 'package:housing/widegts/button.dart';

// class Search_huose extends StatefulWidget {
//   static const String id = '/Search_huose';
//   @override
//   _Search_huoseState createState() => _Search_huoseState();
// }

// class _Search_huoseState extends State<Search_huose> {
//   final TextEditingController _searcheditControllor = TextEditingController();
//   List allRusallt = [];
//   List resalltsearch = [];
//   void initState() {
//     _searcheditControllor.addListener(_onchengSearch);
//     getdataSearcg();
//     super.initState();
//   }

//   _onchengSearch() {
//     print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
//     print(_searcheditControllor.text);
//   }

//   void dispose() {
//     _searcheditControllor.removeListener(_onchengSearch);
//     _searcheditControllor.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangdibansic() {
//     getdataSearcg();
//     super.didChangeDependencies();
//   }

//   searchResultList() {
//     var showResult = [];
//     if (_searcheditControllor.text != '') {
//       for (var clinSnapsot in allRusallt) {
//         var selectCity = clinSnapsot['selectCity'].toString().toLowerCase();
//         if (selectCity.contains(_searcheditControllor.text.toLowerCase())) {
//           showResult.add(clinSnapsot);
//         }
//       }
//     } else {
//       showResult = List.from(allRusallt);
//     }
//     setState(() {
//       resalltsearch = showResult;
//     });
//   }

//   getdataSearcg() async {
//     var data = await FirebaseFirestore.instance
//         .collection('datahuosing')
//         .orderBy('address')
//         .get();
//     setState(() {
//       allRusallt = data.docs;
//     });
//     searchResultList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: btnColor,
//           title: CupertinoSearchTextField(
//             controller: _searcheditControllor,
//             onChanged: (value) {
//               resalltsearch = searchResultList();
//             },
//           ),
//         ),
//         body: ListView.builder(
//           itemCount: resalltsearch.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               child: resalltsearch != null ?
              
//               Center(child: Text('ابحث باسم المحافظه ')):
              
              
//                Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                     decoration: BoxDecoration(
//                         color: cardColor,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           'المحافظه: ${resalltsearch[index]['selectCity']}   ',
//                           style: textstyle,
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text('السعر :  ${resalltsearch[index]['price']}',
//                             style: textstyle),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           'العنوان: ${resalltsearch[index]['address']}   ',
//                           style: textstyle,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         button(
//                             text: 'التفاصيل',
//                             onPressed: () async {
//                               await Navigator.pushNamed(
//                                   context, housing_item.id,
//                                   arguments: allRusallt[index]);
//                             })
//                       ],
//                     ),
//                   ),
//                 ],
//               )
              
//             );
//           },
//         ));
//   }
// }
