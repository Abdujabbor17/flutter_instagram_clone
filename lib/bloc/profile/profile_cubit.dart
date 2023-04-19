

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInit());

  int axisCount = 3;



  changeAxisCount(int newCount){
    axisCount = newCount;
    emit(ProfileInit());
  }
}