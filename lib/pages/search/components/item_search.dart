import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/model/user_model.dart';

Widget itemOfUser(UserModel user) {
  return SizedBox(
    height: 90,
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(70),
            border: Border.all(
              width: 1.5,
              color: const Color.fromRGBO(193, 53, 132, 1),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22.5),
            child: user.imgUrl == null
                ? const Image(
              image: AssetImage("assets/images/ic_person.png"),
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            )
                : Image.network(
              user.imgUrl!,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.fullName ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              user.email ?? '',
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  // if (member.followed) {
                  //   _apiUnFollowMember(member);
                  // } else {
                  //   _apiFollowMember(member);
                  // }
                },
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Center(
                    child:
                    user.followed ? const Text("Following") : const Text("Follow"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}