import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:housing/screens/profil.dart';
import 'package:housing/userScreen/Booking.dart';
import 'package:housing/userScreen/ShowHousing.dart';
import 'package:meta/meta.dart';

part 'home_user_state.dart';

class HomeUserCubit extends Cubit<HomeUserState> {
  HomeUserCubit() : super(HomeUserInitial());
  int selectindx = 0;
  List<Widget> select = <Widget>[
    const Show_Housing(),
    const Booking(),
    const profil(),
    // Search_huose()
  ];

  void SelectIndex(int index) {
    selectindx = index;
    emit(indexSelect());
  }
}
