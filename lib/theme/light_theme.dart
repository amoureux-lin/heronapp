import 'package:flutter/material.dart';

import 'app_themes.dart';

final lightTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
  //自定义扩展
  extensions: const [
    CustomColors(
        brand: Colors.teal,
        warning: Colors.orange
    ),
  ],
);
