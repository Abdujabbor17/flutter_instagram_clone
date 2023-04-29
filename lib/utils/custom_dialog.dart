import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> dialogCommon(
    BuildContext context, String title, String message, bool isSingle) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            !isSingle
                ? MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("Cancel"),
                  )
                : const SizedBox.shrink(),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      });
}
