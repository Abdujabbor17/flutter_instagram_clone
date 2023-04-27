
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/upload/upload_state.dart';
import 'package:flutter_instagram_clone/service/db_service.dart';
import 'package:flutter_instagram_clone/service/file_service.dart';
import 'package:flutter_instagram_clone/utils/toast.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/post_model.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInit());

  final ImagePicker _picker = ImagePicker();
  var captionController = TextEditingController();
  String? path;

  void imgFromGallery() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    path = image!.path;
    emit(UploadLoad(File(image.path)));
  }

  void imgFromCamera() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    path = image!.path;
    emit(UploadLoad(File(image.path)));
  }

  void updateImage(File? newImage){
    emit(UploadLoad(newImage != null ? File( newImage.path ): null));
  }

  Future<void> addPost() async {

    List<String> postImagesUrls = [];
    if(path != null){
      emit(UploadLoading());
      String url = await FileService.uploadPostImage(File(path!));
      postImagesUrls.add(url);
      Post newPost = Post(captionController.text.trim(), postImagesUrls);
      Post addedPost = await DBService.saveMyPost(newPost);
      await DBService.saveFeed(addedPost);

      // path = null;
      // captionController.clear();
      emit(UploadSuccess());
    }else{
      toastError('Please choose image');
      emit(UploadInit());
    }



  }


}