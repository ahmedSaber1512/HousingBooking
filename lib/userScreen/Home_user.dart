import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:housing/Colors/colors.dart';
import 'package:housing/cubit/home_user/home_user_cubit.dart';


class Home_user extends StatefulWidget {
  const Home_user({super.key});
  static const String id = '/Home_user';

  @override
  State<Home_user> createState() => _Home_userState();
}

class _Home_userState extends State<Home_user> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeUserCubit>();
    return BlocBuilder<HomeUserCubit, HomeUserState>(builder: (context, state) {
      return Scaffold(
        body: cubit.select[cubit.selectindx],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: backgroundColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرائسية',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'الحجز',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'الملف الشخصي',
            ),
            // BottomNavigationBarItem(icon: Icon(Icons.more), label: 'المذيد'),
          ],
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
