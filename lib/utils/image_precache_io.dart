import 'dart:io';

import 'package:flutter/material.dart';

Future<void> precacheFileImage(BuildContext context, String path) async {
  final file = File(path);
  if (await file.exists()) {
    if (context.mounted) {
      await precacheImage(FileImage(file), context);
    }
  }
}
