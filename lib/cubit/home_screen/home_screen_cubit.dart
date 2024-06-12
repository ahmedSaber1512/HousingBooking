import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());
  final List<String> imgList = [
    'assets/images/download.jpeg',
    'assets/images/photo2.jpeg',
    'assets/images/photo1.jpeg',
    'assets/images/images.jpeg'
  ];
}
