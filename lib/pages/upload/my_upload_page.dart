import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/upload/upload_cubit.dart';
import 'package:flutter_instagram_clone/bloc/upload/upload_state.dart';

import 'components/show_picker.dart';


class MyUploadPage extends StatefulWidget {

  const MyUploadPage({Key? key}) : super(key: key);

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {

  var captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Upload",
            style: TextStyle(color: Colors.black,fontFamily: 'Billabong'),
          ),
          actions: [
            IconButton(
              onPressed: () {

              },
              icon: const Icon(
                Icons.drive_folder_upload,
                color: Color.fromRGBO(193, 53, 132, 1),
              ),
            ),
          ],
        ),
        body: BlocProvider<UploadCubit>(
          create: (_) => UploadCubit(),
          child: BlocBuilder<UploadCubit,UploadState>(
            builder: (context, state){
              if(state is UploadInit){
                return viewPage(context,null);
              }

              if(state is UploadLoad){
                return viewPage(context,state.image);
              }
              return const Center(child: Text('Nothing'),);
            },
          ),
        )

    );
  }

  Widget viewPage(BuildContext context,File? image){
    return Stack(
      children: [
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showPicker(context);
                     }, 
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.4),
                    child: image == null
                        ? const Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 50,
                        color: Colors.grey,
                      ),
                    )
                        : Stack(
                      children: [
                        Image.file(
                          image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.black12,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<UploadCubit>(context).updateImage(null);
                                },
                                icon: const Icon(Icons.highlight_remove),
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: TextField(
                    controller: captionController,
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        hintText: "Caption",
                        hintStyle:
                        TextStyle(fontSize: 17, color: Colors.black38)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
