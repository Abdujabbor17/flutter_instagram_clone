
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/upload/upload_cubit.dart';

void showPicker(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Pick Photo from gallery'),
                  onTap: () {
                    BlocProvider.of<UploadCubit>(context).imgFromGallery();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading:  const Icon(Icons.photo_camera),
                title:  const Text('Take Photo by camera'),
                onTap: () {
                  BlocProvider.of<UploadCubit>(context).imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      });
}

