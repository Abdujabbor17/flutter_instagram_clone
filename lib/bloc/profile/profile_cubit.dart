
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/profile/profile_state.dart';
import 'package:flutter_instagram_clone/model/user_model.dart';
import 'package:flutter_instagram_clone/service/db_service.dart';
import 'package:flutter_instagram_clone/service/file_service.dart';
import 'package:flutter_instagram_clone/utils/log_service.dart';
import 'package:flutter_instagram_clone/utils/toast.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/post_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInit());

  int axisCount = 3;

  changeAxisCount(int newCount){
    axisCount = newCount;
    emit(ProfileInit());
  }

  Future<void> getProfileInfo() async{
    emit(ProfileLoading());
    var user = await DBService.loadUserInfo();
    var posts = await DBService.loadPosts();
    emit(ProfileLoad(user: user, posts: posts));

  }

  Future<void> uploadImage( String path) async{
    Log.wtf(path);
    emit(ProfileLoading());
    var url = await FileService.uploadUserImage(File(path));
    UserModel user = await DBService.loadUserInfo();
    user.imgUrl = url;
    await DBService.updateUser(user);
    UserModel newUser = await DBService.loadUserInfo();

    var posts = await DBService.loadPosts();
    emit(ProfileLoad(user: newUser, posts: posts));

  }


  final ImagePicker _picker = ImagePicker();

  void imgFromGallery() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if(image != null){
      await uploadImage(image.path);
    }else{
      toastError('Something is wrong');
    }
  }

  void imgFromCamera() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if(image != null){
      await uploadImage(image.path);
    }else{
      toastError('Something is wrong');
    }
  }

  void removePost(Post post) async {
    emit(ProfileLoading());

    await DBService.removePost(post);
    var posts = await DBService.loadFeeds();
    var user = await DBService.loadUserInfo();
    emit(ProfileLoad(user: user, posts: posts));


  }
}