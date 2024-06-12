import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/screens/setting.dart';
import 'package:housing/models/getdata.dart';
import 'package:housing/userScreen/housing_item.dart';
import 'package:housing/widegts/button.dart';

class Show_Housing extends StatefulWidget {
  static const String id = '/Show_Housing';

  const Show_Housing({super.key});
  @override
  _Show_HousingState createState() => _Show_HousingState();
}

class _Show_HousingState extends State<Show_Housing> {
  final TextEditingController _searcheditControllor = TextEditingController();
  List<GetdataModel> allRusallt = [];
  List<GetdataModel> resalltsearch = [];
  @override
  void initState() {
    _searcheditControllor.addListener(_onchengSearch);
    getdataSearch();
    super.initState();
  }

  _onchengSearch() {
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print(_searcheditControllor.text);
  }

  @override
  void dispose() {
    _searcheditControllor.removeListener(_onchengSearch);
    _searcheditControllor.dispose();
    super.dispose();
  }

  @override
  void didChangdibansic() {
    getdataSearch();
    super.didChangeDependencies();
  }

  searchResultList() {
    List<GetdataModel> showResult = [];
    if (_searcheditControllor.text != '') {
      for (var clinSnapsot in allRusallt) {
        var selectCity = clinSnapsot.selectCity.toString().toLowerCase();
        if (selectCity.contains(_searcheditControllor.text.toLowerCase())) {
          showResult.add(clinSnapsot);
        }
      }
    } else {
      showResult = List.from(allRusallt);
    }
    setState(() {
      resalltsearch = showResult;
    });
  }

  getdataSearch() async {
    var data = await FirebaseFirestore.instance
        .collection('datahuosing')
        .where('status', isEqualTo: 'published')
        .orderBy('address')
        .get();
    for (var element in data.docs) {
      var item = GetdataModel.fromJson(element.data());
      item.dataUid = element.id;
      allRusallt.add(item);
    }
    setState(() {});
    searchResultList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notification_important,
                    color: btnColor,
                  ))
            ],
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingScreen()));
                },
                icon: const Icon(
                  Icons.settings,
                  color: btnColor,
                )),
            backgroundColor: backgroundColor,
            title: CupertinoSearchTextField(
              backgroundColor: btnColor,
              controller: _searcheditControllor,
              onChanged: (value) {
                resalltsearch = searchResultList();
              },
            ),
            centerTitle: true,
          ),
          // appBar: AppBar(
          //   centerTitle: true,
          //   backgroundColor: btnColor,
          //   title: CupertinoSearchTextField(
          //     controller: _searcheditControllor,
          //     onChanged: (value) {
          //       resalltsearch = searchResultList();
          //     },
          //   ),
          // ),
          body: ListView.builder(
            itemCount: resalltsearch.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: textbtnColor, width: .5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            height: 150,
                            child: resalltsearch[index].imageUrls[0] != null
                                ? Image.network(
                                    resalltsearch[index].imageUrls[0],
                                    fit: BoxFit.fill,
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(190, 224, 232, 234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              'المحافظه: ${resalltsearch[index].selectCity}   ',
                              style: textstyle,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                                'السعر :  ${resalltsearch[index].price}',
                                style: textstyle),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(190, 224, 232, 234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              'العنوان: ${resalltsearch[index].address}   ',
                              style: textstyle,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(190, 224, 232, 234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              'النوع: ${resalltsearch[index].selectType}   ',
                              style: textstyle,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(190, 224, 232, 234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                                'طبيعيه الغرفه :  ${resalltsearch[index].selectroom}',
                                style: textstyle),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(190, 224, 232, 234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              'كود السكن: ${resalltsearch[index].codeHuosing}   ',
                              style: textstyle,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(190, 224, 232, 234),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Text(
                              ' الوصف: ${resalltsearch[index].description}   ',
                              style: textstyle,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          button(
                              text: 'التفاصيل',
                              onPressed: () async {
                                Get.toNamed(housing_item.id,
                                    arguments: allRusallt[index]);
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
