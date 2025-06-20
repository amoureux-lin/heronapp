import 'package:flutter/material.dart';

import 'app_themes.dart';

final pinkTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
  //自定义扩展
  extensions: const [
    CustomColors(
        brand: Colors.teal,
        warning: Colors.orange
    ),
  ],
);
