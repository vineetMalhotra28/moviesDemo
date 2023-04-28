import 'package:flutter/material.dart';

Widget DetailRow(String title, var data) {
  return Row(
    children: [
      Text(
        '$title',
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: Text(
          '${data}',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ],
  );
}
