import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:housing/housingScreen/BookingInquiry.dart';
import 'package:housing/housingScreen/HomeScreen.dart';
import 'package:housing/housingScreen/thisHousing.dart';
import 'package:housing/screens/profil.dart';
import 'package:meta/meta.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit() : super(HomeViewInitial());
  int selectindx = 0;
  List<Widget> select = <Widget>[
    HomeScreen(),
    const BookingInquiry(),
    const thishousing(),
    const profil(),
  ];
  void SelectIndex(int index) {
    selectindx = index;
    emit(indexselecet());
  }
}
