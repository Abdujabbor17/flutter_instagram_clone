import 'dart:io';

import 'package:flutter/material.dart';


class MyUploadPage extends StatefulWidget {

  const MyUploadPage({Key? key}) : super(key: key);

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Upload",
            style: TextStyle(color: Colors.black),
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
      );
  }
}
