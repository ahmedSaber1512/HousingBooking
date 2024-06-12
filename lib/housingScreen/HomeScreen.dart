import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/home_screen/home_screen_cubit.dart';
import 'package:housing/housingScreen/Add_Housing.dart';
import 'package:housing/screens/setting.dart';
import 'package:housing/widegts/button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeScreenCubit>();
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notification_important,
                color: btnColor,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingScreen()));
                },
                icon: const Icon(
                  Icons.settings,
                  color: btnColor,
                ))
          ],
          backgroundColor: backgroundColor,
          title: const Text(
            'الصفحة الرئيسية',
            style: TextStyle(
                fontSize: 22, color: btnColor, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: context.height / 1.5,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: cubit.imgList
                  .map((item) => Container(
                        child: Center(
                            child: Image.asset(item,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                width: double.infinity)),
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            button(
                text: 'اضف سكن',
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Add_Housing()));
                })
          ],
        ),
      );
    });
  }
}
