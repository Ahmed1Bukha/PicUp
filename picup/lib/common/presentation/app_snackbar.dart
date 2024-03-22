import 'package:flutter/material.dart';

showSnackBar(context, String content) {
  final snackBar = SnackBar(
    content: Text(content),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
