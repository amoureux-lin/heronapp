import 'package:flutter/material.dart';

import 'app_themes.dart';

final blueTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  //自定义扩展
  extensions: const [
    CustomColors(
        brand: Colors.blue,
        warning: Colors.orange
    ),
  ],
);
