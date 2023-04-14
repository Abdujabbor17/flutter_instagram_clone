
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/post_model.dart';
import '../../states.dart';
import 'components/itemOfPost.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Instagram",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
            color: const Color.fromRGBO(193, 53, 132, 1),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPost(context, items[index]);
            },
          ),
          isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
