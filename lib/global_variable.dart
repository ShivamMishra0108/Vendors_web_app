import 'package:flutter/material.dart';

String uri = 'http://localhost:3000';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}

