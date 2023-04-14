import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageCubit extends Cubit<int> {
  ImageCubit() : super(0);
  PageController pageController = PageController();

  void changeImage(int index) {
    emit(index);
  }
}