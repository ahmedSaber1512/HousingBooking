import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:housing/admin/admin.dart';
import 'package:housing/cubit/admin/admi_cubitn.dart';
import 'package:housing/cubit/add_housing/add_housing_cubit.dart';
import 'package:housing/cubit/bookingHousing/booking_housing_cubit.dart';
import 'package:housing/cubit/home_screen/home_screen_cubit.dart';
import 'package:housing/cubit/home_user/home_user_cubit.dart';
import 'package:housing/cubit/home_view/home_view_cubit.dart';
import 'package:housing/cubit/housing_item/housing_item_cubit.dart';
import 'package:housing/cubit/login/login_cubit.dart';
import 'package:housing/cubit/profil/profil_cubit.dart';
import 'package:housing/cubit/sinup/sinup_cubit.dart';
import 'package:housing/cubit/thisHousing/this_housing_cubit.dart';
import 'package:housing/models/user_model.dart';
import 'package:housing/screens/Splash_Screen.dart';
import 'package:get/get.dart';
import 'package:housing/housingScreen/Add_Housing.dart';
import 'package:housing/housingScreen/Home_Viwe.dart';
import 'package:housing/housingScreen/thisHousing.dart';
import 'package:housing/userScreen/Home_user.dart';
import 'package:housing/screens/LoginScreen.dart';
import 'package:housing/screens/RegsterScreen.dart';
import 'package:housing/userScreen/ShowHousing.dart';
import 'package:housing/userScreen/housing_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? user = prefs.getString('user_data');
  if (user != null) {
    userModel = UserModel.fromJson(jsonDecode(user));
  }
  runApp(MultiProvider(providers: [
    Provider<HomeViewCubit>(
      create: (_) => HomeViewCubit(),
    ),
    Provider<LoginCubit>(
      create: (_) => LoginCubit(),
    ),
    Provider<SinupCubit>(
      create: (_) => SinupCubit(),
    ),
    Provider<ProfilCubit>(
      create: (_) => ProfilCubit(),
    ),
    Provider<AddHousingCubit>(
      create: (_) => AddHousingCubit(),
    ),
    Provider<BookingHousingCubit>(
      create: (_) => BookingHousingCubit(),
    ),
    Provider<HomeScreenCubit>(
      create: (_) => HomeScreenCubit(),
    ),
    Provider<ThisHousingCubit>(
      create: (_) => ThisHousingCubit(),
    ),
     Provider<HomeUserCubit>(
      create: (_) => HomeUserCubit(),
    ),
    Provider<HousingItemCubit>(
      create: (_) => HousingItemCubit(),
    ),
    Provider<AdminCubit>(
      create: (_) => AdminCubit(),
    ),
    
    // other providers
  ], child: MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),

        RegsterScreen.id: (context) => const RegsterScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        // RegsterScreen1.id: (context) => RegsterScreen1(),
        // LoginScreen1.id: (context) => LoginScreen1(),
        Add_Housing.id: (context) => const Add_Housing(),
        Show_Housing.id: (context) => const Show_Housing(),
        housing_item.id: (context) => const housing_item(),
        Home_view.id: (context) => const Home_view(),
        Home_user.id: (context) => const Home_user(),
        thishousing.id: (context) => const thishousing(),
        Admin_Screnn.id: (context) => const Admin_Screnn(),

        // HomeScreenAdimin.id :(context) => const HomeScreenAdimin()
      },
      initialRoute: getRoute(),
      // home: const SplashScreen()
    );
  }
}

String getRoute() {
  switch (userModel.role) {
    case UserRole.admin:
      return Admin_Screnn.id;
    case UserRole.poster:
      return Home_view.id;
    case UserRole.user:
      return Home_user.id;
    default:
      return SplashScreen.id;
  }
}

UserModel userModel = UserModel();
