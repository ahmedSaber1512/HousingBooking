import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/home_view/home_view_cubit.dart';

class Home_view extends StatefulWidget {
  const Home_view({super.key});
  static const String id = '/Home_view';
  @override
  State<Home_view> createState() => _Home_viewState();
}

class _Home_viewState extends State<Home_view> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeViewCubit>();
    return BlocBuilder<HomeViewCubit, HomeViewState>(builder: (context, state) {
      return Scaffold(
        body: cubit.select[cubit.selectindx],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'الرائسية',
                backgroundColor: backgroundColor),

            BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'الحجز',
                backgroundColor: backgroundColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_max_outlined),
                label: 'سكني',
                backgroundColor: backgroundColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'الملف الشخصي',
                backgroundColor: backgroundColor),
            // BottomNavigationBarItem(icon: Icon(Icons.more), label: 'المزيد'),
          ],
          backgroundColor: backgroundColor,
          currentIndex: cubit.selectindx,
          selectedItemColor: btnColor,
          unselectedItemColor: btnColor,
          showUnselectedLabels: true,
          onTap: cubit.SelectIndex,
        ),
      );
    });
  }
}
