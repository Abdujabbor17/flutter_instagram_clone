
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/upload/upload_state.dart';
import 'package:image_picker/image_picker.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadInit());

  final ImagePicker _picker = ImagePicker();

  void imgFromGallery() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    emit(UploadLoad(File(image!.path)));
  }

  void imgFromCamera() async {
    XFile? image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    emit(UploadLoad(File(image!.path)));
  }

  void updateImage(File? newImage){
    emit(UploadLoad(newImage != null ? File( newImage.path ): null));
  }


}