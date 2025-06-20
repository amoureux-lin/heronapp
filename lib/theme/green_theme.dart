import 'package:flutter/material.dart';

import 'app_themes.dart';

final greenTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
  //自定义扩展
  extensions: const [
    CustomColors(
        brand: Colors.green,
        warning: Colors.orange
    ),
  ],
);
