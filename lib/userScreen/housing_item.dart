import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/housing_item/housing_item_cubit.dart';
import 'package:housing/models/getdata.dart';
import 'package:housing/widegts/button.dart';

class housing_item extends StatefulWidget {
  static const String id = '/housing_item';
  const housing_item({super.key});

  @override
  State<housing_item> createState() => _housing_itemState();
}

class _housing_itemState extends State<housing_item> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HousingItemCubit>();
    var data = ModalRoute.of(context)!.settings.arguments as GetdataModel;
    return BlocBuilder<HousingItemCubit, HousingItemState>(
        builder: (context, state) {
     
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: btnColor,
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo_whit.png'),
                  radius: 18,
                ),
              ),
            ],
            centerTitle: true,
            title: const Text(
              'تفاصيل السكن  ',
              style: TextStyle(fontSize: 22, color: btnColor),
            ),
            backgroundColor: backgroundColor,
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Form(
                key: cubit.form,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: textbtnColor, width: .5)),
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var i in data.imageUrls)
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: SizedBox(
                                  width: context.height / 3,
                                  height: 150,
                                  child: i != null
                                      ? Image.network(i, fit: BoxFit.fill)
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(190, 224, 232, 234),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            'المحافظه: ${data.selectCity}   ',
                            style: textstyle,
                          )),
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
                          child: Text('النوع : ${data.selectType} ',
                              style: textstyle)),
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
                          child: Text('نوع السكن : ${data.selectroom} ',
                              style: textstyle)),
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
                          child: Text('العنوان:${data.address} ',
                              style: textstyle)),
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
                          child: Text('كود: ${data.codeHuosing}',
                              style: textstyle)),
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
                          child:
                              Text('السعر:${data.price} ', style: textstyle)),
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
                          child: Text('الوصف : ${data.description}  ',
                              style: textstyle)),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Expanded(
                                child: button(
                                    text: ' واتس اب',
                                    onPressed: () {
                                      cubit.sendWhatsAppMessage(
                                          "+2${data.phone}", "hi ahmed");
                                    })),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: button(
                                    text: data.isAnswerAccept != null &&
                                            data.isAnswerAccept == true
                                        ? "تم حجز العقار"
                                        : 'حجز',
                                    onPressed: () async {
                                      if (data.isAnswerAccept == null ||
                                          data.isAnswerAccept == false) {
                                        await cubit.sentOrederData(
                                            data.codeHuosing,
                                            data.dataUid ?? '',
                                            data.posterUid!);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('تم ارسال الطلب')));
                                      }
                                    }))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
      );
    });
  }
}
